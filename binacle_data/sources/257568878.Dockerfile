FROM alpine:3.4
MAINTAINER janes - https://github.com/hxer

ENV PACKAGES="\
  #build-base \
  #bash \
  #ca-certificates \
  python \
  python-dev \
  py-pip \
  git \
  curl \
  nmap \
"

ENV PY_PACKAGES="\
  sqlmap \
  dnspython \
"

RUN apk add --update $PACKAGES && \
    pip install --upgrade pip && \
    pip install $PY_PACKAGES 

RUN mkdir /root/tool/
WORKDIR /root/tool/

RUN git clone https://github.com/lijiejie/subDomainsBrute.git
RUN git clone https://github.com/maurosoria/dirsearch.git
RUN git clone https://github.com/stanislav-web/OpenDoor.git && \
    cd OpenDoor && pip install -r requirements.txt

CMD ["/bin/sh"]
