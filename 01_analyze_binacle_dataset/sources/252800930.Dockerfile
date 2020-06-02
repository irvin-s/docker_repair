FROM download13/alpine-tls  
  
RUN apk-install nodejs \  
&& npm -g update npm  

