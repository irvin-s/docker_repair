FROM frolvlad/alpine-python2  
MAINTAINER Code Climate <hello@codeclimate.com>  
  
RUN apk --update add git  
RUN git clone https://github.com/codeclimate/Scout2 /app  
  
WORKDIR /app  
RUN git reset --hard a0a7b72060cc09e6b3f8204ab1e4852b1ff93053  
RUN pip install -r requirements.txt  
  
COPY files /  
ENTRYPOINT ["/bin/entrypoint"]  

