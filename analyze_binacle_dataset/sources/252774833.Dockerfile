FROM alpine  
  
LABEL maintainer="casey@caseyweed.com"  
LABEL version="0.1"  
  
RUN apk update && apk add python3  
COPY ./ /tmp/dwms  
RUN cd /tmp/dwms && \  
pip3 install -r requirements.txt && \  
pip3 install .  
  
ENTRYPOINT ["dude"]  

