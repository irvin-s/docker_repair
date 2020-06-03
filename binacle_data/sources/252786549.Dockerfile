FROM python:2.7.14  
LABEL maintainer="nielsonnas@gmail.com"  
  
RUN apt-get update && apt-get install -y gettext  
  
ADD ./requirements.txt /root/requirements.txt  
RUN pip install -U virtualenv && pip install -r /root/requirements.txt  
  
ADD ./bashrc.sh /root/.bashrc  
RUN sed -i 's/\r//' /root/.bashrc  
  
WORKDIR /var/task  
  
CMD ["zappa"]

