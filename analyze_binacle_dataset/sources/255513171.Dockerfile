FROM nginx:1.10.1
LABEL application=intake_accelerator
HEALTHCHECK --interval=3s --retries=20 CMD curl -fs http://localhost:${HTTP_PORT:-81}
RUN apt-get update -y && \
    apt-get install curl -y
COPY nginx.conf /etc/nginx/nginx.conf
