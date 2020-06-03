FROM alpine:3.7  
# ARG APM_HOME=/usr/share/apm-server  
ENV APM_USER=apm-server \  
APM_GROUP=apm-server \  
APM_HOME=/usr/share/apm-server  
  
COPY . /tmp/build  
RUN /tmp/build/build_image.sh  
  
USER ${APM_USER}  
WORKDIR ${APM_HOME}  
VOLUME ${APM_HOME}  
EXPOSE 8200  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["-e"]

