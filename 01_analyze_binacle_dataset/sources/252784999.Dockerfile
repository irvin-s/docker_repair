FROM codeserver/base:latest  
MAINTAINER Neil Ellis hello@neilellis.me  
EXPOSE 80  
CMD ["/sbin/my_init"]  
  
ENV GITHUB_USER neilellis  
ENV GITHUB_PROJECT codeserver-example  
ENV GITHUB_BRANCH master  
ENV PAID_AC false  
ENV GO_VERSION 1.4.2  
ENV VERTX_VERSION 2.1.5  
ENV PATH $PATH:/usr/local/vert.x-${VERTX_VERSION}/bin  
# Set environment variables.  
ENV GOROOT /usr/local/go  
ENV PATH $GOROOT/bin:$PATH  
  
WORKDIR /root  
  
############################### END OF INITIAL
################################  
COPY build.sh /root/build.sh  
RUN chmod 755 /root/build.sh ; sleep 1; /root/build.sh  
  
COPY *.yml /app/  
COPY bin/* /usr/local/bin/  
COPY etc/ /usr/local/etc/  
COPY lib/* /usr/local/lib/  
COPY info/ /usr/local/info  
  
RUN mkdir -p /etc/service/admin /etc/service/app \  
/usr/local/var /usr/local/cache /usr/local/tmp /usr/local/app \  
/etc/service/xvfb /etc/service/cleanup /etc/service/log \  
/etc/service/update_check  
  
RUN cp /usr/local/etc/fluent.conf /etc/fluent.conf && \  
cp /usr/local/bin/xvfb.sh /etc/service/xvfb/run &&\  
cp /usr/local/bin/serverhub_admin.sh /etc/service/admin/run && \  
cp /usr/local/bin/init.sh /etc/my_init.d/99_init_runtime && \  
cp /usr/local/bin/cleanup.sh /etc/service/cleanup/run && \  
cp /usr/local/bin/app.sh /etc/service/app/run && \  
cp /usr/local/bin/update_check.sh /etc/service/update_check/run && \  
cp /usr/local/bin/log.sh /etc/service/log/run  
  
RUN chmod 755 /etc/service/admin/run /etc/my_init.d/99_init_runtime \  
/etc/service/app/run /etc/service/xvfb/run /etc/service/update_check/run \  
/etc/service/cleanup/run /etc/service/log/run /usr/local/bin/*  
  
RUN for i in `find / -perm +6000 -type f`; do chmod a-s $i; echo "Removed SUID
from $i"; done  
  
ENV SERVICE_ACCESS_TOKEN ABC123  
ENV SERVICE_ID ABC  
ENV SERVICE_KEY 123  
ENV AWS_ACCESS_KEY_ID none  
ENV AWS_SECRET_ACCESS_KEY none  
ENV AWS_DEFAULT_REGION us-east-1  
EXPOSE 8080  
EXPOSE 8888  

