# NLTK REST Webservice
#
# VERSION 0.1
# 
# BUILDAS sudo docker build -t named-entity-service .
# RUNAS sudo docker run -d -p 5000:5000 named-entity-service


FROM nlothian/python-nltk
MAINTAINER Nick Lothian nick.lothian@gmail.com

# Expose port 5000
expose 5000


# Get the service
RUN mkdir -p /var/local/acuitra
RUN git init /var/local/acuitra/
RUN cd /var/local/acuitra;git remote add -f origin https://github.com/nlothian/Acuitra.git
RUN cd /var/local/acuitra;git config core.sparseCheckout true
RUN cd /var/local/acuitra;echo services/named-entity-service/*> .git/info/sparse-checkout
RUN cd /var/local/acuitra;git checkout master

# Run the service
# RUN /usr/bin/python /var/local/acuitra/services/named-entity-service/named-entity-ws.py  

CMD ["/usr/bin/python", "/var/local/acuitra/services/named-entity-service/named-entity-ws.py"]

  
