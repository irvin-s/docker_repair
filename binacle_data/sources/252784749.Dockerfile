FROM alpine:3.5  
#  
# BASE PACKAGES  
#  
RUN apk add --no-cache \  
bash \  
python \  
py2-pip \  
py2-crypto \  
py2-curl \  
py2-jinja2 && \  
pip install --upgrade pip && \  
mkdir /pyapp/  
  
#  
# PREPARE USER MODE  
#  
COPY run.sh /pyapp/run.sh  
COPY docker-entrypoint.sh /opt/docker-entrypoint.sh  
RUN touch /pyapp/run.sh && \  
addgroup -g 10777 pyworker && \  
adduser -D -G pyworker -u 10777 pyworker && \  
chown root:root /pyapp/run.sh && \  
chmod u+rwx,g+rwx,o-w,o+rx /pyapp/run.sh && \  
chmod o+rx /pyapp && \  
mkdir -p /pyapp/web && chown -R pyworker:root /pyapp/web && \  
mkdir -p /pyapp/data && chown -R pyworker:root /pyapp/data && \  
chmod u+rx,g+rx,o+rx,a-w /opt/docker-entrypoint.sh  
  
#  
# VOLUMES AND EXPOSE  
#  
WORKDIR "/pyapp/web"  
VOLUME ["/pyapp/web"]  
VOLUME ["/pyapp/data"]  
EXPOSE 8000  
#  
# RUN IN USER MODE  
#  
USER pyworker  
ENTRYPOINT ["/opt/docker-entrypoint.sh"]  
CMD ["/pyapp/run.sh"]  

