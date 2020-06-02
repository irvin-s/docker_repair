FROM node:8  
MAINTAINER xun "me@xun.my"  
  
RUN yarn global add semantic-release-gitlab  
  
# ENTRYPOINT ["/usr/local/bin/semantic-release-gitlab"]  
  
# CMD ["swagger2aglio", "--help"]  
# docker build -t axnux/semantic-release-gitlab:latest . #  

