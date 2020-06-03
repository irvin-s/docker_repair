FROM debian:9  
ARG DOCKER_BUILD_PROXY=""  
RUN set -uex; \  
http_proxy="${DOCKER_BUILD_PROXY:-}"; \  
apt-get update; \  
apt-get install -y stress-ng  
  
ENTRYPOINT ["stress-ng"]  
CMD ["--help"]  

