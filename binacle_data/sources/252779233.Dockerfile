FROM bytesized/base  
MAINTAINER maran@bytesized-hosting.com  
  
RUN apk --no-cache add python python-dev git py-pip unrar  
RUN git clone https://github.com/SickRage/SickRage.git --depth 2 /app/sickrage  
  
EXPOSE 8081  
COPY static/ /  
  
VOLUME /data /config /media  

