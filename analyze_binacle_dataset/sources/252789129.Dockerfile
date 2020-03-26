FROM dockerfile/python  
MAINTAINER dsociative  
  
RUN apt-get update  
RUN apt-get -y install python-dev g++  
  
RUN easy_install "https://github.com/dsociative/doom/archive/staging.tar.gz"  
  
EXPOSE 8885  
ENTRYPOINT ["/usr/bin/python", "-m", "doom.example.hello_talker"]  

