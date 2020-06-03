
# Slightly modified version of dockerfile/nginx to make /etc/nginx availible as a volume

# Run as:  docker run -d -p 80:80  oyvindsk/simple_http_proxy
#
# Or with volumes to make it easier to edit the config. Copy the /etc/nginx folder out of the container and re-start the container:
#     mkdir -p ~/docker-volume-nginx/log
#     docker run -d oyvindsk/simple-http-proxy
#     docker cp <container id>:/etc/nginx ~/docker-volume-nginx/
#     docker stop <container id>
#     docker run -d -p 80:80 -v ~/docker-volume-nginx/nginx:/etc/nginx -v ~/docker-volume-nginx/log:/var/log/nginx oyvindsk/sime-http-proxy


FROM dockerfile/nginx
MAINTAINER Øyvind Skaar


ADD proxy.conf         /etc/nginx/
ADD proxy_domains.conf /etc/nginx/

# Define mountable directories.
VOLUME ["/data", "/etc/nginx", "/var/log/nginx"]

ENTRYPOINT ["nginx"]
CMD ["-c", "/etc/nginx/proxy.conf"]
