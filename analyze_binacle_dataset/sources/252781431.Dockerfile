#Version 1.0.0  
FROM ubuntu  
MAINTAINER Raju P "ptbraju@gmail.com"  
ONBUILD : ADD . /mydir/  
ADD * /mydir/  
VOLUME ["/mnt/test/" ]  
WORKDIR /home  
EXPOSE 80  
RUN apt-get update && apt-get install -y nginx \  
&& apt-get install -y python-pip  
RUN pip install pexpect  
RUN pip install flask  
RUN echo "Hello World "  
  

