# Сервер хранилища 1С 8.3  
#  
FROM 32bit/debian  
MAINTAINER asda (Andrey Mamaev)  
  
ENV DIST deb32_8.3.10-2580.tar.gz  
  
  
RUN apt-get update && apt-get install -y \  
wget  
  
ENV SRV1CV8_REPOSITORY /opt/1C/repository  
  
RUN mkdir /opt/dist && cd /opt/dist/ \  
&& wget http://casa.ru/${DIST} \--no-check-certificate \  
&& tar xzf ${DIST} && dpkg -i *.deb && rm -rf *  
  
RUN mkdir -p /var/log/1c/dumps && chmod -R 777 /var/log/1c  
  
RUN mkdir ${SRV1CV8_REPOSITORY}  
RUN chmod 777 ${SRV1CV8_REPOSITORY}  
  
VOLUME ${SRV1CV8_REPOSITORY}  
  
EXPOSE 1542  
CMD ["/opt/1C/v8.3/i386/crserver","-d","/opt/1C/repository"]  

