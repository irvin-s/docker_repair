# ubuntu14.04  
FROM ubuntu:14.04  
MAINTAINER AndyHelix <andyhelix@gmail.com>  
RUN apt-get -qq update  
#RUN apt-get -qqy install ruby ruby-dev  
RUN apt-get -qqy install curl  
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3  
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby  
#RUN which source  
CMD ['source', '/usr/local/rvm/scripts/rvm']  
CMD ['gem', '-v']  
CMD ['gem', 'install lotusrb']  
CMD ['locate', 'lotus']  
  
CMD ['cd','/src/lotus']  
CMD ['pwd']  
  
#RUN cd /src/lotus/myapp; pwd; ls -l; bundle; bundle exec lotus server  

