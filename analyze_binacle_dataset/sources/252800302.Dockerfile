FROM ubuntu  
RUN apt-get update && \  
apt-get install -y curl && \  
curl install.meteor.com | /bin/sh  
  
WORKDIR /  
RUN meteor create hello  
  
WORKDIR /hello  
CMD ["meteor"]  

