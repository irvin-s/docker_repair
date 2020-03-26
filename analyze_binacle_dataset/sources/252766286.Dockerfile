FROM ubuntu:latest  
MAINTAINER Ahmed ABERWAG <aberwag@gmail.com>  
  
RUN DEBIAN_FRONTEND=noninteractive \  
apt-get update && \  
apt-get install -qy git curl  
  
ENV NODE_VERSION 4.4.0  
ENV NPM_VERSION 3.8.0  
ENV NPM_CMD npm start  
ENV PROJECT_DIR /app  
ENV GIT_REPO ''  
COPY ./scripts/lunch-script.sh /scripts/lunch-script.sh  
  
RUN git clone https://github.com/creationix/nvm.git ${HOME}/.nvm  
RUN echo '. /scripts/lunch-script.sh' >> $HOME/.profile  
  
WORKDIR ${PROJECT_DIR}  
  
ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]  
CMD ["bash"]  

