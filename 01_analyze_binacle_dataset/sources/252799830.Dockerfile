FROM node:4  
MAINTAINER it@digitalgarden.com.au  
  
# Install global dependencies.  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends bash \  
&& rm -rf /var/lib/apt/lists/*;  
  
# Create 'app' user.  
RUN userdel --remove node \  
&& groupadd --gid 1000 app \  
&& useradd --uid 1000 \--gid app --shell /bin/bash --create-home app \  
&& mkdir -p /home/app/src/docroot \  
&& mkdir -p /home/app/.local/opt \  
&& mkdir -p /home/app/bin \  
&& mkdir -p /home/app/.local/bin \  
&& mkdir -p /home/app/src/docroot \  
&& echo '. "$HOME/.bashrc"' >> /home/app/.profile \  
&& echo 'export PATH=$HOME/bin:$PATH' >> /home/app/.bashrc \  
&& echo 'export PATH=$HOME/.local/bin:$PATH' >> /home/app/.bashrc \  
&& chown -R app:app /home/app  
  
# Install global packages to '/home/app/.npm-packages'.  
RUN mkdir -p /home/app/.npm-packages \  
&& echo 'prefix=/home/app/.npm-packages' >> /home/app/.npmrc \  
&& echo 'export PATH=$HOME/.npm-packages/bin:$PATH' >> /home/app/.bashrc \  
&& chown -R app:app /home/app  
  
CMD ["tail", "-f", "/dev/null"]  
WORKDIR /home/app/src/docroot  

