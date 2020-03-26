FROM dockercloud/hello-world:latest
ADD nginx.conf /etc/nginx
EXPOSE 8123
LABEL \
  com.opentable.sous.repo_url=github.com/docker/dockercloud-hello-world \
  com.opentable.sous.repo_offset= \
  com.opentable.sous.version=0.0.1-latest \
  com.opentable.sous.revision=8fea0e35282799fcbaae974844c83a7f336acc05 \
