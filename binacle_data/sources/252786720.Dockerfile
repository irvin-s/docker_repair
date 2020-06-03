FROM alpine:edge  
  
RUN apk --no-cache add py3-psycopg2 py3-docopt  
  
WORKDIR /usr/src/app  
  
COPY . .  
  
RUN pip3 install -e .  
  
ENTRYPOINT ["migrate"]  

