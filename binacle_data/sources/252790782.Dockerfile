FROM nginx  
RUN mkdir /data/myvol -p  
RUN echo "put some text here" > /data/myvol/test  
VOLUME /data/myvol  

