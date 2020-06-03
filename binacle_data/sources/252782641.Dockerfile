FROM dockercloud/haproxy:1.5.3  
RUN pip install --upgrade pip && \  
pip install boto3==1.2.1  
COPY haproxy-s3cert /haproxy-s3cert  
ENTRYPOINT ["/sbin/tini", "--"]  
CMD ["/haproxy-s3cert/entrypoint.sh"]  

