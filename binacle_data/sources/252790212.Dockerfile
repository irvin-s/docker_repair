FROM ubuntu:16.04  
  
RUN apt-get -y update && apt-get -y upgrade  
RUN apt-get -y install links nano htop git wget  
  
# Install Ruby  
# The -dev version of Ruby is necessary to avoid  
# "cannot load such file -- mkmf (LoadError)" error when installing  
# Jekyll.  
# See http://askubuntu.com/questions/305884/how-to-install-jekyll  
RUN apt-get install -y ruby rubygems-integration ruby-dev make  
  
# required to build 'therubyracer' native gem extension  
RUN apt-get install -y g++  
  
# Python 3 is installed by default, but this creates a conflict with  
# the Pygments highlighting library. The solution is to install  
# Python 2.7 and ensure it is available on the $PATH as `python2`.  
RUN apt-get install -y python2.7  
RUN ln -s /usr/bin/python2.7 /usr/bin/python2  
  
# required to avoid ExecJS::RuntimeUnavailable errors when running  
# jekyll. See https://github.com/jekyll/jekyll/issues/2327  
RUN gem install execjs therubyracer  
  
# Install dependencies for Jekyll packages  
RUN apt-get install zlib1g-dev  
  
# Install the Jekyll version 2.5.3  
#RUN gem install jekyll -v 2.5.3  
RUN gem install github-pages  
  
# Additional gems  
#RUN gem install jekyll-watch  
#RUN gem install jekyll-sitemap  
#RUN gem install jekyll-feed  
#RUN gem install jekyll-gist  
# Expose the default port from jekyll  
EXPOSE 4000  
  
# Set the default workdir  
RUN mkdir /jekyll  
VOLUME /jekyll  
WORKDIR /jekyll  
  
# Set the default command to execute at launch  
CMD ["jekyll", "serve", "--watch", "--force_polling"]  

