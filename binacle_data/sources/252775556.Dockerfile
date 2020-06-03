FROM ubuntu  
MAINTAINER bladerangel <pedrorangel-10@hotmail.com>  
  
### Instalação de programas auxiliares ###  
RUN apt-get update \  
&& apt-get install -y \  
curl \  
git \  
gitg \  
nano \  
software-properties-common \  
unzip \  
zip \  
&& rm -rf /var/lib/apt/lists/*  
  
### Criação e utilização do usuário developer ###  
RUN useradd -p "" -ms /bin/bash developer  
ENV HOME /home/developer  
  
USER developer  
  
### Definição do diretório de trabalho ###  
WORKDIR $HOME  
  
###### Instalação do Java e Grails ######  
RUN curl -s get.sdkman.io | bash  
RUN /bin/bash -c "source $HOME/.sdkman/bin/sdkman-init.sh \  
&& sdkman_curl_connect_timeout=30 \  
&& sdkman_curl_max_time=50 \  
&& sdk install java \  
&& sdk install grails"  
  
### Exposição da porta utilizada para desenvolvimento ###  
EXPOSE 8080  

