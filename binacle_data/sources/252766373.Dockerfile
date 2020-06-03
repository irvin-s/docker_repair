FROM alpine:3.7  
MAINTAINER Ivan Pedrazas <ipedrazas@gmail.com>  
  
RUN apk add --update \  
git \  
python \  
python-dev \  
py-pip \  
g++ && \  
pip install cookiecutter && \  
apk del g++ py-pip python-dev && \  
rm -rf /var/cache/apk/* && \  
printf "#!/bin/sh \ncookiecutter -o \$OUT_DIR \$TEMPLATE" > start.sh && \  
chmod +x start.sh  
  
CMD ["./start.sh"]  

