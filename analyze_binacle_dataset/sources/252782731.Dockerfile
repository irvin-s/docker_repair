FROM ubuntu  
RUN apt-get update -y && apt-get install -y git perl build-essential  
ENV PATH "$PATH:/rumprun/rumprun/bin"  
ENTRYPOINT ["/rumprun-packages/.docker-build/build-package.sh"]  

