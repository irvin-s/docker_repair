#  
# Volume container for monacoind.  
#  
FROM busybox  
  
VOLUME /wallet  
  
ADD monacoin.conf /wallet/monacoin.conf  
  
CMD /bin/sh  

