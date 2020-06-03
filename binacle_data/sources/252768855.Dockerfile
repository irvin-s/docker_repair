FROM nginx:1-alpine  
ADD build.sh .  
ENV PASSWORD SERVERS  
RUN sh build.sh  
ADD index.html.source .  
ADD nginx.conf.source .  
ADD run.py .  
CMD python run.py

