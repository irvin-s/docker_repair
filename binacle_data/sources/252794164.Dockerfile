FROM darron/docker-harp  
  
ADD . /srv/www  
RUN cd /srv/www; ln -s /usr/local/lib/node_modules node_modules  
  
EXPOSE 5000  
CMD cd /srv/www; /usr/bin/node server.js

