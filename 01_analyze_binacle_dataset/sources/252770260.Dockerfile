FROM aschults/minecraft_docker:server_base  
ENV minecraft_version 1.8.9  
ENV forge_version 11.15.1.1902  
RUN sh build.sh  
  

