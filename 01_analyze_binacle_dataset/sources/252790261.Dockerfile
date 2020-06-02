FROM scratch  
ADD vividcortex.tar.xz /  
MAINTAINER VividCortex <containers@vividcortex.com>  
LABEL app=vividcortex  
  
WORKDIR /  
ENTRYPOINT ["/usr/local/bin/vc-agent-007","-foreground","-forbid-restarts"]  
  

