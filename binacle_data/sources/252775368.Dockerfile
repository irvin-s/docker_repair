# This is not the best of ideas b/c we don't know what version of python  
# we are using or what version of BusyBox.  
FROM odise/busybox-python  
  
# Who created and/or is maintaining the Dockerfile and, ultimately, the  
# Docker image built from it.  
MAINTAINER Boyd Hemphill <behemphi@gmail.com>  
  
# This is the home for the code within the container.  
ADD . /code  
WORKDIR /code  
  
# Because this is based on busy-box and pip is not available, we will  
# just use easy_install.  
RUN easy_install flask  
  
# Just a dumb way to run this for now. Need some love in this area when  
# we want to be more sophisticated  
CMD python app.py  
  

