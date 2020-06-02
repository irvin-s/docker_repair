# LoopBack App Base Image  
# Installs StrongLoop and Git  
FROM node:latest  
  
# Create base directories  
RUN mkdir /srv/cityscope  
RUN mkdir /srv/cityscope/loopback  
WORKDIR /srv/cityscope/loopback  
COPY . /srv/cityscope/loopback  
RUN chmod +x /srv/cityscope/loopback/startup.sh  
  
RUN useradd -m -s /bin/bash -N -u 1000 jovyan  
USER jovyan  
  
# Download node depencencies  
RUN mkdir /tmp/loopback  
WORKDIR /tmp/loopback  
COPY ./package.json /tmp/loopback  
RUN cd /tmp/loopback && npm install  
  
# Move node dependencies to the user $HOME  
RUN mv /tmp/loopback/node_modules /home/jovyan/.node-packages  
RUN rm -rf /tmp/loopback  
  
# Point NODE_PATH to the extracted dependencies  
ENV NODE_PATH=/home/jovyan/.node-packages  
ENV NODE_ENV=production  
  
# Expose standard loopback port  
EXPOSE 3000  
#Add base entrypoint  
ENTRYPOINT ["/srv/cityscope/loopback/startup.sh"]  

