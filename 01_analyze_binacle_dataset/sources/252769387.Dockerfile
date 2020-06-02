FROM httpd:2.4  
MAINTAINER AnnPin  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update  
RUN apt-get install -y \  
apache2 \  
mysql-server \  
# rails server 時のJavaScript Runtime(CoffeeScript -> js)用にNodeを入れる  
nodejs \  
perl \  
make \  
unzip \  
bzip2 \  
tar \  
vim \  
curl \  
wget \  
sudo \  
apt-utils \  
git \  
man  
  
RUN rm -rf /var/www && \  
mkdir /www && \  
ln -s /www /var/www  
  
ADD ./setup.sh /setup.sh  
ADD ./install.sh /install.sh  
RUN chmod a+x /setup.sh && chmod a+x /install.sh  
WORKDIR /  
  
RUN /bin/bash -c "/install.sh"  
  
CMD ["/setup.sh"]  
  
EXPOSE 80  
EXPOSE 3000  

