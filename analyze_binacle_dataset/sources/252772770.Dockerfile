FROM datadog/docker-dd-agent:latest-alpine  
ADD haproxy.yaml /opt/datadog-agent/agent/conf.d/haproxy.yaml  
RUN apk add --no-cache curl  

