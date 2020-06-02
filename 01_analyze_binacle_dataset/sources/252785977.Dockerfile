FROM atlassian/default-image:latest  
MAINTAINER Dave Clark "dave.clark@clarkyoungman.com"  
# building on top of the default image from Atlassian  
RUN echo "Installing pip and AWS cli tools" \  
&& wget https://bootstrap.pypa.io/get-pip.py \  
&& python get-pip.py && pip install awscli  

