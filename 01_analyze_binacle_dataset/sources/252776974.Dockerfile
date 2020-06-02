FROM drydock/u14:prod  
MAINTAINER Matt Snider (matt@cleanenergyexperts.com)  
  
# Updating Apt-get  
RUN mkdir -p /tmp && chmod 1777 /tmp  
RUN apt-add-repository -y ppa:brightbox/ruby-ng  
RUN add-apt-repository -y ppa:chris-lea/node.js  
RUN add-apt-repository -y ppa:danmbox/ppa  
RUN apt-get -y update  
  
# Install Ruby 2.2  
RUN apt-get -y install ruby2.2 ruby2.2-dev  
RUN gem install bundler  
  
# Install NodeJS  
RUN apt-get -y install nodejs  
  
# Install Dependencies  
RUN apt-get -y install \  
git \  
libxml2 \  
libxml2-dev \  
libxslt1-dev \  
libssl-dev \  
g++ \  
zlib1g-dev \  
checkinstall \  
zip \  
python-software-properties \  
python2.7-dev \  
python-pip \  
make \  
build-essential \  
software-properties-common  
  
# Install eb for Deployments  
RUN pip install awsebcli  
  
# TODO: Install postgresql as needed for testing

