FROM node:alpine  
  
LABEL maintainer="open-source@6go.it" \  
vendor="6go.it" \  
version=1.1.1  
  
ENV HOME /home/node  
ENV USER node  
  
WORKDIR ${HOME}  
  
COPY config ${HOME}  
RUN mkdir -p app \  
&& chown -R ${USER}:${USER} app package.json .profile  
  
EXPOSE 80  
  
USER ${USER}  
  
WORKDIR app  
  
CMD ["tail", "-f", "/dev/null"]  

