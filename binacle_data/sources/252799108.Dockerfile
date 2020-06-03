FROM deweysasser/s3fs  
MAINTAINER Dewey Sasser <dewey@sasser.com>  
  
RUN apt-get update  
RUN apt-get install -y nginx  
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf  
  
# Work around an issue mounting s3 buckets so they can be read by  
# www-data. This isn't a good idea, but it is necessary for now.  
RUN perl -i -p -e "s/user www-data;/user root;/" /etc/nginx/nginx.conf  
  
RUN rm /etc/nginx/sites-enabled/default  
COPY site.conf /etc/nginx/sites-available/s3-site.conf  
RUN ln -s /etc/nginx/sites-available/s3-site.conf /etc/nginx/sites-enabled  
  
ENV SUBDIR "html"  
RUN mv /root/run /root/s3run  
COPY run /root/run  
  
CMD ["nginx"]  
  
EXPOSE 80  
EXPOSE 443

