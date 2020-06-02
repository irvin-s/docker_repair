FROM alpine  
  
MAINTAINER Yosuke Matsusaka <yosuke.matsusaka@gmail.com>  
  
RUN apk add --no-cache tini iptables  
  
ADD enforce-rules.sh /bin  
  
ENV CHAIN_NAME "CONTAINER-FIREWALL"  
ENV ACCEPT_PORT "80,443"  
ENTRYPOINT ["/sbin/tini", "--"]  
  
CMD ["/bin/enforce-rules.sh"]

