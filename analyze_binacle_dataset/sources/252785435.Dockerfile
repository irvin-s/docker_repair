FROM colstrom/python  
  
RUN apk-install gcc musl-dev python3-dev \  
&& pip install bpython \  
&& apk del gcc musl-dev python3-dev \  
&& rm -rf /root/.cache  
  
ENTRYPOINT ["bpython"]  

