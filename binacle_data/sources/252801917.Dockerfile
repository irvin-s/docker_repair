FROM node:latest  
  
# Surpress Upstart errors/warning  
RUN dpkg-divert --local \--rename --add /sbin/initctl  
RUN ln -sf /bin/true /sbin/initctl  
  
# Let the container know that there is no tty  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install software requirements  
RUN apt-get update && \  
apt-get install -y git  
RUN npm install -g node-gyp  
  
# Install Supervisor  
RUN apt-get install -y supervisor  
  
# Install/setup Python deps  
RUN apt-get install -y python-pip  
RUN pip install requests  
  
# Copy supervisor config  
ADD conf/supervisord.conf /etc/supervisord.conf  
  
# Add git commands to allow container updating  
ADD scripts/pull /usr/bin/pull  
ADD scripts/push /usr/bin/push  
ADD scripts/docker-hook /usr/bin/docker-hook  
ADD scripts/hook-listener /usr/bin/hook-listener  
RUN chmod 755 /usr/bin/pull && chmod 755 /usr/bin/push  
RUN chmod +x /usr/bin/docker-hook  
RUN chmod +x /usr/bin/hook-listener  
  
# copy start script  
ADD scripts/start.sh /usr/bin/start.sh  
  
# Expose Ports (example: 80)  
EXPOSE 80  
EXPOSE 8555  
# run start script  
CMD ["/bin/bash", "/usr/bin/start.sh"]

