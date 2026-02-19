#!/usr/bin/env python3

import json
import subprocess
import sys

TERRAFORM_DIR = "../terraform"  # Ajuste o caminho conforme necessário


def get_all_outputs():
    try:
        result = subprocess.run(
            ["terraform", "output", "-json"],
            cwd=TERRAFORM_DIR,
            capture_output=True,
            text=True,
            check=True
        )
        return json.loads(result.stdout)
    except subprocess.CalledProcessError:
        return {}


def generate_inventory():
    tf_outputs = get_all_outputs()

    inventory = {
        "_meta": {"hostvars": {}}
    }

    groups_created = []

    for output_name, output_data in tf_outputs.items():

        if "value" not in output_data:
            continue

        output_value = output_data["value"]

        if not isinstance(output_value, dict):
            continue

        # Detecta grupos automaticamente, outputs devem seguir o padrão <group_name>_public_ips ou
        #<group_name>_private_ips (Ex: web_public_ips, db_private_ips)
        if output_name.endswith("_public_ips"):
            group_name = output_name.replace("_public_ips", "")
        elif output_name.endswith("_private_ips"):
            group_name = output_name.replace("_private_ips", "")
        else:
            continue

        inventory[group_name] = {"hosts": []}
        groups_created.append(group_name)

        for hostname, ip in output_value.items():
            inventory[group_name]["hosts"].append(hostname)

            inventory["_meta"]["hostvars"][hostname] = {
                "ansible_host": ip,
            }

    if groups_created:
        inventory["all_vms"] = {
            "children": groups_created
        }

    return inventory


if __name__ == "__main__":
    if len(sys.argv) == 2 and sys.argv[1] == "--list":
        print(json.dumps(generate_inventory(), indent=2))
    else:
        print(json.dumps({}))
