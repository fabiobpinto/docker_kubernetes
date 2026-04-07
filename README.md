# Docker, Kubernetes, Ansible e Terraform — Labs e Anotações

Repositório com **laboratórios práticos**, exemplos e anotações relacionados a **Docker**, **Kubernetes**, **Ansible** e **Terraform**.

> O código e os laboratórios deste repositório foram construídos com base em cursos que realizei, servindo como material de estudo e referência.

---

## 📁 Estrutura do repositório

```text
.
├── ansible/
├── docker/
├── kubernetes/
└── terraform/
```

Abaixo está um resumo do que existe em cada pasta.

---

## 🤖 `ansible/`

Conteúdo voltado à automação de configuração (provisionamento/instalação) usando Ansible.

**Arquivos e pastas principais:**

- `ansible/ansible.cfg` — arquivo de configuração do Ansible.
- `ansible/playbook_docker.yml` — playbook para instalação/configuração relacionada a Docker.
- `ansible/playbook_kubernetes.yml` — playbook para instalação/configuração relacionada a Kubernetes.
- `ansible/inventory/`
  - `ansible/inventory/terraform.py` — inventário dinâmico em Python (usado para obter hosts via Terraform/estado, por exemplo).
- `ansible/roles/`
  - `ansible/roles/docker/` — role com tarefas/handlers/vars para Docker.
  - `ansible/roles/kubernetes/` — role com tarefas/handlers/vars para Kubernetes.

---

## 🐳 `docker/`

Laboratórios e exemplos para aprender/consolidar conceitos de Docker (Dockerfile, build, camadas, healthcheck, limites, docker-compose e stacks).

**Arquivos e pastas principais:**

- `docker/Comandos Docker.txt` — anotações com comandos úteis.

### `docker/Lab01-Dockerfile/`
Lab introdutório de **Dockerfile**: empacotar uma página HTML simples com Nginx.

- `docker/Lab01-Dockerfile/Dockerfile`
- `docker/Lab01-Dockerfile/index.html`
- `docker/Lab01-Dockerfile/README.md`

### `docker/Lab02-CMD_Entrypoint/`
Lab para entender diferenças e uso prático de **CMD** vs **ENTRYPOINT**.

- `docker/Lab02-CMD_Entrypoint/Dockerfile.cmd`
- `docker/Lab02-CMD_Entrypoint/Dockerfile.entrypoint`
- `docker/Lab02-CMD_Entrypoint/Dockerfile.combination`
- `docker/Lab02-CMD_Entrypoint/hello.sh`
- `docker/Lab02-CMD_Entrypoint/README.md`

### `docker/Lab03-Multi-Stage/`
Lab com exemplo de **multi-stage build** (inclui exemplo em Go).

- `docker/Lab03-Multi-Stage/Dockerfile.multistage`
- `docker/Lab03-Multi-Stage/Dockerfile.sem`
- `docker/Lab03-Multi-Stage/main.go`

### `docker/Lab04-Healthcheck/`
Exemplo de **HEALTHCHECK** em Dockerfile.

- `docker/Lab04-Healthcheck/Dockerfile`
- `docker/Lab04-Healthcheck/index.html`

### `docker/Lab05-Dockerfile-Advanced/`
Lab com variações e práticas avançadas de Dockerfile (inclui exemplos “broken”, multi-stage e otimizações).

- `docker/Lab05-Dockerfile-Advanced/Dockerfile`
- `docker/Lab05-Dockerfile-Advanced/Dockerfile.broken`
- `docker/Lab05-Dockerfile-Advanced/Dockerfile.multi`
- `docker/Lab05-Dockerfile-Advanced/Dockerfile.otimizado`
- `docker/Lab05-Dockerfile-Advanced/.dockerignore`
- `docker/Lab05-Dockerfile-Advanced/config.json`
- `docker/Lab05-Dockerfile-Advanced/app/` — código/exemplo usado no build.
- `docker/Lab05-Dockerfile-Advanced/docs/` — documentação do lab.
- `docker/Lab05-Dockerfile-Advanced/tests/` — testes/validações.
- `docker/Lab05-Dockerfile-Advanced/README.md`

### `docker/Lab06-User/`
Exemplo de boas práticas para execução com **usuário não-root**.

- `docker/Lab06-User/Dockerfile`

### `docker/Lab07-LimitResources/`
Exemplo de configuração relacionada a **limites de recursos**.

- `docker/Lab07-LimitResources/Dockerfile`

### `docker/Lab08-DockerCompose/`
Lab com **Docker Compose** (projeto de exemplo com múltiplos serviços) e materiais auxiliares.

- `docker/Lab08-DockerCompose/docker-compose.yml`
- `docker/Lab08-DockerCompose/docker-compose.images.yml`
- `docker/Lab08-DockerCompose/docker-stack.yml`
- `docker/Lab08-DockerCompose/README.md`
- `docker/Lab08-DockerCompose/healthchecks/`
- `docker/Lab08-DockerCompose/k8s-specifications/` — especificações/manifestos para execução em Kubernetes.
- `docker/Lab08-DockerCompose/seed-data/` — dados iniciais.
- `docker/Lab08-DockerCompose/vote/` — serviço/app de votação.
- `docker/Lab08-DockerCompose/worker/` — worker de processamento.
- `docker/Lab08-DockerCompose/result/` — serviço/app de resultados.

### `docker/Lab09-DockerCompose/`
Outro lab relacionado a compose/stack.

- `docker/Lab09-DockerCompose/simple-stack/`

---

## ☸️ `kubernetes/`

Laboratórios e exemplos relacionados a Kubernetes (conceitos, serviços e microserviços).

**Pastas principais:**

- `kubernetes/labs/` — coleção de labs.
  - `kubernetes/labs/01-Concepts-Pods-ReplicaSet-Deployments/` — conceitos iniciais (Pods, ReplicaSet, Deployments).
  - `kubernetes/labs/02-Services/` — serviços (ClusterIP/NodePort/LoadBalancer, etc.).
  - `kubernetes/labs/03-Microservices/` — exemplos de microserviços.
  - `kubernetes/labs/modulo01-Fundamentals/` — exercícios/conteúdos do módulo 01.
  - `kubernetes/labs/modulo02-ContainerOrchestration/` — exercícios/conteúdos do módulo 02.
  - `kubernetes/labs/config.yaml` — arquivo de configuração usado pelos labs.

- `kubernetes/terraform/` — artefatos relacionando Kubernetes + Terraform (ex.: provisionamento de infraestrutura para clusters, quando aplicável).

---

## 🌍 `terraform/`

Infraestrutura como código (IaC) utilizando Terraform.

**Arquivos principais:**

- `terraform/main.tf` — recursos principais.
- `terraform/provider.tf` — configuração do(s) provider(s).
- `terraform/variables.tf` — variáveis do projeto.
- `terraform/outputs.tf` — outputs.
- `terraform/prd.tfvars` — valores de variáveis para o ambiente (ex.: produção/lab).
- `terraform/.terraform.lock.hcl` — lockfile de providers.
- `terraform/README.md` — documentação específica do lab (ex.: Azure Load Balancer Lab).

### `terraform/modules/`
Módulos reutilizáveis (organização por responsabilidades):

- `terraform/modules/resource_group/`
- `terraform/modules/virtual_network/`
- `terraform/modules/nsg/`
- `terraform/modules/public_ip/`
- `terraform/modules/vm_linux/`

---

## ✅ Como usar este repositório

Como existem diferentes laboratórios independentes, a forma de execução varia por pasta.

Sugestões:

- Para **Docker**, entre em `docker/Lab*/` e siga o `README.md` do respectivo lab (quando existir).
- Para **Kubernetes**, entre em `kubernetes/labs/` e execute os manifests com `kubectl` conforme o lab.
- Para **Terraform**, entre em `terraform/` e/ou siga `terraform/README.md`.
- Para **Ansible**, ajuste inventário/variáveis e rode os playbooks em `ansible/`.

---

## 👤 Autor

Fábio Brito Pinto
