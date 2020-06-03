FROM cdata/minecraft:1.7.2  
MAINTAINER Chris Joel <chris@scriptolo.gy>  
  
ENV BUILDDIR /build  
  
ADD playbook.yml $BUILDDIR/playbook.yml  
ADD roles $BUILDDIR/roles  
  
RUN ansible-playbook $BUILDDIR/playbook.yml -c local  
  
EXPOSE 25565  
VOLUME /minecraft/volume  
  
ENTRYPOINT /minecraft/start_server.sh  

