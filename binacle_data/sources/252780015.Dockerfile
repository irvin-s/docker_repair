FROM node:6  
MAINTAINER xun "me@xun.my"  
  
RUN npm install -g swagger2aglio  
  
# ENTRYPOINT ["/usr/local/bin/swagger2aglio"]  
  
# CMD ["swagger2aglio", "--help"]  
# docker build -t axnux/swagger2aglio:latest . #  

