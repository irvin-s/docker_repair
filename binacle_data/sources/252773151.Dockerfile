FROM conoria/alpine-pandoc  
MAINTAINER blackgamer@mbj.nifty.com  
  
RUN apk --update add python3 make && \  
pip3 install --upgrade pip && \  
pip3 install bottle  
RUN mkdir -p /var/www/diary  
ADD . /var/www/diary  
WORKDIR /var/www/diary  
EXPOSE 80  
CMD ["sh", "./run.sh"]  

