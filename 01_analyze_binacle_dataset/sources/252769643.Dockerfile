FROM gdepuille/docker-node-static  
LABEL maintainer = "Gregory DEPUILLE <gregory.depuille@gmail.com>"  
  
# Création d'une arborescence de constuction  
ENV BUILD_WORK_DIR /appbuild  
RUN mkdir -p ${BUILD_WORK_DIR} && mkdir -p ${BUILD_WORK_DIR}/src  
  
# Installation des outils de build Angular CLI  
RUN mkdir $HOME \  
&& npm install -g @angular/cli \  
&& npm cache clean \  
&& rm -rf ~/.npm \  
&& rm -rf /tmp/npm*  
  
# Ajout des sources de l'application  
ADD .*.json ${BUILD_WORK_DIR}/  
ADD *.json ${BUILD_WORK_DIR}/  
ADD src ${BUILD_WORK_DIR}/src/  
  
# Build / Déplacement de l'application construite et nettoyage des sources  
RUN cd ${BUILD_WORK_DIR} \  
&& mkdir $HOME \  
&& npm install \  
&& ng build --env=prod \  
&& mv dist/* /app \  
&& npm cache clean \  
&& rm -rf ~/.npm \  
&& rm -rf /tmp/npm* \  
&& cd /app \  
&& rm -rf ${BUILD_WORK_DIR}  
  
CMD ["http-server", "-r", "-p 80"]  

