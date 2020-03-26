FROM python:2-alpine  
  
RUN mkdir -p /app && apk add --update bc iproute2  
WORKDIR /app  
VOLUME ["/app/gremlins/profiles"]  
  
ADD gremlins /app/gremlins  
ADD setup.py /app/setup.py  
RUN python setup.py develop  
  
ADD entrypoint.sh /app/entrypoint.sh  
ADD profile.tmpl /app/profile.tmpl  
ENTRYPOINT ["/app/entrypoint.sh"]  
CMD ["gremlins","-m","gremlins.profiles.entropy","-p","entropy.profile"]  

