FROM jhipster/jhipster:v3.11.0  
#  
# Alguns servidores de CI não se dão bem com usuário não root.  
#  
USER root  
  
#  
# Configuração do bower para aceitar ser executado como root  
#  
COPY assets/.bowerrc /.bowerrc  
  
#  
# Heroku  
#  
RUN apt-get update && \  
apt-get install -y sudo ruby-full && \  
rm -rf /var/lib/apt/lists/*  
  
RUN \  
wget -qO- https://toolbelt.heroku.com/install.sh | sh  
  
RUN \  
ln -s /usr/local/heroku/bin/heroku /usr/bin/heroku && \  
heroku --version && \  
heroku plugins:install heroku-cli-deploy  

