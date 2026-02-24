FROM ubuntu:24.04

# Instalar Nginx e curl
RUN apt-get update && apt-get install -y nginx curl && rm -rf /var/lib/apt/lists/*

# Remover conteúdo padrão do Nginx
RUN rm -rf /var/www/html/*

# Copiar o site
COPY index.html /var/www/html/

# Expor porta 80
EXPOSE 80

# HEALTHCHECK
HEALTHCHECK --interval=5s --timeout=3s --start-period=3s --retries=3 \
  CMD curl -f http://localhost:80/ || exit 1

# Iniciar Nginx e manter container rodando
CMD ["sh", "-c", "service nginx start && tail -f /dev/null"]
