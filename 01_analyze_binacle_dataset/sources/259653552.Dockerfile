FROM nginx
RUN apt-get update && apt-get install -y iptables curl
EXPOSE 80
