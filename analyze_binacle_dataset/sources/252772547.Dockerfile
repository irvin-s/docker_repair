FROM alpine:3.4  
MAINTAINER toolbox@cloudpassage.com  
  
RUN apk add -U \  
gettext \  
git \  
python \  
py-pip  
  
COPY ./ /source/  
  
WORKDIR /source/  
  
RUN pip install -r requirements-testing.txt  
  
CMD /source/runner.sh  

