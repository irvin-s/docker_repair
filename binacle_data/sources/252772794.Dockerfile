FROM busybox  
  
MAINTAINER Yury Kotov <bairkan@yandex.ru>  
  
ENV GEMS_PATH=/.gem  
  
RUN mkdir -p $GEMS_PATH && \  
chmod g+rw $GEMS_PATH  
  
VOLUME $GEMS_PATH  
  
CMD ["sh"]  

