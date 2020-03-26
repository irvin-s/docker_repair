FROM debian:jessie  
  
ENV DEBIAN_FRONTEND=noninteractive  
  
RUN apt-get update && apt-get install -y \  
tor \  
ca-certificates  
VOLUME ["/var/lib/tor/hidden_service/"]  
  
RUN useradd -ms /bin/bash tor  
USER tor  
  
CMD ["tor"]

