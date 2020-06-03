FROM debian:wheezy-backports  
  
MAINTAINER Raphaël Carles <raphael.carles@businessdecision.com>  
  
ENV TERM xterm  
  
RUN systemMods=" \  
net-tools \  
vim \  
dialog \  
apt-utils \  
xterm \  
man-db \  
manpages-fr \  
curl \  
wget \  
openssl \  
acl \  
htop \  
git \  
graphicsmagick \  
python-software-properties \  
apache2 \  
apache2-utils \  
" \  
&& apt-get update \  
&& apt-get install -y $systemMods \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Create default apache2 conf  
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf  
  
# enabled apache2 modules  
RUN a2enmod rewrite \  
&& a2enmod headers \  
&& a2enmod deflate \  
&& a2enmod ldap \  
&& a2enmod ssl \  
&& a2enmod proxy  
  
# dot files  
COPY ./dot/.bash_git /root/.bash_git  
COPY ./dot/.bash_aliases /root/.bash_aliases  
RUN echo "source /root/.bash_aliases" >> /root/.bashrc  
RUN echo "source /root/.bash_git" >> /root/.bashrc  
  
# ADD Docker User  
RUN addgroup --gid=1000 docker \  
&& adduser --system --uid=1000 --shell /bin/bash docker \  
&& echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers  
  
# CMD script  
COPY ./run.sh /run.sh  
RUN chmod +x /run.sh  
  
WORKDIR /var/www/html  
  

