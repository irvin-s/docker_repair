FROM alpine  
MAINTAINER Diego Ruggeri <diego@ruggeri.net.br> (@diegor2)  
  
RUN apk --update --no-cache add \  
python3 \  
fortune \  
ca-certificates \  
openssl  
  
RUN pip3 install --upgrade pip \  
&& pip install \  
python-telegram-bot \  
requests \  
qrcode  
  
COPY src /var/local/quebot  
WORKDIR /var/local/quebot  
  
ENTRYPOINT ["/var/local/quebot/docker-entrypoint.sh"]  
  
CMD [ "/usr/bin/python3", "telebot.py" ]  

