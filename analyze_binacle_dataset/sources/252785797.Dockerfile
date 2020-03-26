FROM alpine:latest  
MAINTAINER David Sn <divad.nnamtdeis@gmail.com>  
  
ENV GIT_REPO https://github.com/divadsn/geoip-api.git  
ENV PYTHONIOENCODING utf-8  
# Install python along with virtualenv  
RUN apk add --no-cache --update \  
python3 \  
python3-dev \  
py-pip \  
build-base \  
git \  
openssl-dev \  
libxml2-dev \  
libxslt \  
libxslt-dev \  
py-libxslt \  
py-libxml2 \  
py-lxml \  
libssl1.0 \  
ca-certificates \  
wget && \  
pip install --upgrade pip && \  
pip install virtualenv && \  
update-ca-certificates && \  
rm -rf /var/cache/apk/*  
  
# Clone geoip-api repo from GitHub and install requirements  
RUN git clone $GIT_REPO /src && \  
rm -rf /src/.git && \  
cd /src && virtualenv -p python3 .venv && \  
source .venv/bin/activate && \  
pip install -r requirements.txt  
  
WORKDIR /src  
EXPOSE 8069  
ENTRYPOINT [ "/src/.venv/bin/python", "/src/server.py" ]

