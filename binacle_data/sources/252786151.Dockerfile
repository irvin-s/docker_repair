FROM node:6.5.0  
RUN npm install -g bower  
ADD bower.sh /  
ADD bower-github.json /.config/configstore/  
RUN chmod -R 777 /.config  
RUN mkdir /.cache && chmod 777 /.cache  
RUN mkdir /.local && chmod 777 /.local  
RUN chmod 4755 /usr/sbin/useradd  
ENTRYPOINT ["/bower.sh"]  

