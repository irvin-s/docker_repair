FROM haproxy:1.4-alpine  
MAINTAINER Bradley Leonard <bradley@leonard.pub>  
  
RUN apk add --no-cache bash  
  
# make the src folder available in the docker image  
ADD src/ /src  
  
EXPOSE 80  
CMD ["haproxy", "-f", "/src/haproxy.spec"]  

