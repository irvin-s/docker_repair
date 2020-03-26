#Build an image that can run generator-gulp-angular  
FROM ubuntu:trusty  
MAINTAINER Ajay Ganapathy <lets.talk@designbyajay.com>  
RUN apt-get -yq update && apt-get -yq upgrade  
#  
# Install pre-requisites  
RUN apt-get -yq install python-software-properties \  
software-properties-common \  
python \  
g++ \  
make \  
git \  
libfreetype6  
#  
# Install node.js, yo, gulp, bower, and generator-gulp-angular  
RUN apt-get install -yq curl \  
&& curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - \  
&& apt-get -yq install nodejs \  
&& apt-get -yq update \  
&& npm install -g yo \  
gulp \  
bower \  
generator-gulp-angular \  
modernizr \  
&& npm update  
#  
# Add a yeoman user because yeoman doesn't like being root  
RUN adduser --disabled-password --gecos "" \--shell /bin/bash yeoman; \  
echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers  
ENV HOME /home/yeoman  
#  
# set up a directory that will hold the files we sync from the host machine  
RUN mkdir /home/yeoman/senior-studio-site \  
# set up a directory for global npm packages that does not require root access  
&& mkdir /home/yeoman/.npm_global \  
&& chmod -R 777 /home/yeoman  
ENV NPM_CONFIG_PREFIX /home/yeoman/.npm_global  
WORKDIR /home/yeoman/senior-studio-site  
VOLUME /home/yeoman/senior-studio-site  
#  
# allow the host machine to access browsersync on the guest machine  
EXPOSE 3000-3001  
#  
# drop to yeoman user and a bash shell  
USER yeoman  
CMD ["/bin/bash"]  

