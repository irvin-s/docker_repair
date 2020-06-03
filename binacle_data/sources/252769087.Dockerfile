FROM python:2.7.9  
WORKDIR /var/drinkbot/program/  
  
ADD . /var/drinkbot/program/  
  
RUN pip install supervisor && \  
pip install -r requirements.txt && \  
mkdir -p /var/drinkbot/runtime/supervisord/slack  
  
ADD ./config/supervisord.conf /etc/  
  
CMD ["supervisord", "-c", "/etc/supervisord.conf"]  
  
VOLUME /var/drinkbot/runtime/supervisord/slack  
  
EXPOSE 8989  

