FROM erlang:18  
MAINTAINER Jose L. Navarro <jlnavarro111@gmail.com>  
  
VOLUME /opt/erlang_app  
WORKDIR /opt/erlang_app  
  
# install required packages  
RUN apt-get update && apt-get install -y \  
git \  
curl \  
wget \  
make \  
gcc \  
libc6-dev \  
libncurses5-dev \  
libssl-dev \  
libexpat1-dev \  
libpam0g-dev  
  
# To install docker, run the following command as root:  
RUN wget -qO- https://get.docker.com/ | sh  
  
ADD ./entrypoint.sh /  
  
# compile source  
ENTRYPOINT ["/entrypoint.sh"]  

