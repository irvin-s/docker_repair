FROM apluslms/grading-nodejs:6.x  
  
ADD package.json /root  
RUN cd /root && npm install -g  
ENV NODE_PATH /usr/lib/node_modules/globals/node_modules/  
  
RUN pip install html5lib \  
&& rm -rf /root/.cache  
  
ADD bin /usr/local/bin  

