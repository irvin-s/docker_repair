FROM cypress/base:4  
  
RUN mkdir -p /app \  
&& npm config set user 0 \  
&& npm --global install --no-save cypress \  
&& cypress verify  
  
WORKDIR /app  
  
VOLUME ["/app"]  

