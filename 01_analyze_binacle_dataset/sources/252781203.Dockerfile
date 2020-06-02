FROM frolvlad/alpine-python2  
  
COPY . /  
  
RUN apk add --update --nocache docker && pip install hooked waitress  
  
EXPOSE 8888  
ENTRYPOINT ["hooked", "/server.cfg"]  

