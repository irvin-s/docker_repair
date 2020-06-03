FROM alpine  
  
COPY dockerexp.js /icingamon/  
COPY package.json /icingamon/  
COPY run.sh /  
  
RUN apk update && apk upgrade \  
&& apk add --no-cache nodejs \  
&& cd /icingamon && npm i \  
&& chmod +x /run.sh  
  
VOLUME ["/icingamon"]  
CMD ["/run.sh"]

