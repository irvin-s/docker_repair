FROM alpine:3.7  
LABEL maintainer="Angristan https://github.com/Angristan/dockerfiles"  
LABEL source="https://github.com/Angristan/dockerfiles/tree/master/isso"  
  
ARG ISSO_VER=0.10.6  
ENV GID=4242 UID=4242  
RUN apk -U upgrade \  
&& apk add --no-cache -t build-dependencies \  
python-dev \  
libffi-dev \  
py2-pip \  
build-base \  
&& apk --no-cache add \  
python \  
py-setuptools \  
sqlite \  
libressl \  
ca-certificates \  
su-exec \  
tini \  
&& pip install --no-cache cffi \  
&& pip install --no-cache misaka==1.0.2 \  
&& pip install --no-cache "isso==${ISSO_VER}" \  
&& apk del build-dependencies \  
&& rm -rf /tmp/*  
  
COPY run.sh /usr/local/bin/run.sh  
  
RUN chmod +x /usr/local/bin/run.sh  
  
EXPOSE 8080  
VOLUME /isso/database  
  
CMD ["run.sh"]

