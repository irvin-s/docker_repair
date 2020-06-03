FROM nginx:1.10
ADD ./aws-ecs-nginx-proxy-linux /opt/aws-ecs-nginx-proxy
ENTRYPOINT ["/opt/aws-ecs-nginx-proxy"]
