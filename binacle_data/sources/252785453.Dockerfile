FROM colstrom/alpine  
  
RUN apk-install openssl python \  
&& wget https://bootstrap.pypa.io/get-pip.py -O - | python \  
&& apk del openssl  
  
ENTRYPOINT ["python"]  

