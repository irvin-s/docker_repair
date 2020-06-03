# Quepy Webservice
#
# BUILDAS sudo docker build -t quepy-service .
# RUNAS sudo docker run -d -p 5001:5001 quepy-service /usr/bin/python /var/local/acuitra/services/quepy-service/webservice.py
#
# VERSION 0.1



# Ubuntu 12.04
FROM nlothian/python-nltk
MAINTAINER Nick Lothian nick.lothian@gmail.com

# Expose port 5001
expose 5001

# Quepy
RUN pip install quepy

# GIT
RUN apt-get -y install git

# Get the service
RUN mkdir -p /var/local/acuitra
RUN git init /var/local/acuitra/
RUN cd /var/local/acuitra;git remote add -f origin https://github.com/nlothian/Acuitra.git
RUN cd /var/local/acuitra;git config core.sparseCheckout true
RUN cd /var/local/acuitra;echo services/quepy-service/*> .git/info/sparse-checkout
RUN cd /var/local/acuitra;git checkout master

# Run the service
# RUN /usr/bin/python /var/local/acuitra/services/quepy-service/webservice.py  



  
