FROM cheggwpt/ruby:0.0.5  
# Make the app directory  
# install the fake s3 gem without docs  
RUN mkdir -p /var/data/fakes3 && \  
gem install fakes3 --no-ri --no-rdoc  
  
# Add the files  
COPY container_confs /  
  
# fake s3 environment vars  
ENV S3_USERNAME convox  
ENV S3_PASSWORD password  
ENV S3_PATH /bucket  
ENV S3_PORT 4569  
# LINK env vars for convox  
ENV LINK_USERNAME convox  
ENV LINK_PASSWORD password  
ENV LINK_PATH /bucket  
ENV LINK_PORT 4569  
# expose the fake s3 port  
EXPOSE 4569  
# expose the app volume  
VOLUME ["/var/data/fakes3"]  
  
# default command for entrypoint.sh  
CMD ["/start_fakes3.sh"]  
  

