FROM tensorflow/tensorflow  
  
#Maintainer  
MAINTAINER Caocao <martin.mengdj@gmail.com>  
  
RUN \  
DEBIAN_FRONTEND=noninteractive apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get -y install lrzsz unzip && \  
DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/*  
  
ADD ./ /app  
WORKDIR /app  
  
RUN chmod 755 run_app.sh  
RUN pip install --upgrade pip  
RUN pip install -r requirements.txt  
  
EXPOSE 80  
CMD ["run_app.sh"]  

