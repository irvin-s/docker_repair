FROM tutum/apache-php  
  
ENV PIWIK_VERSION 2.12.1  
RUN apt-get update && \  
apt-get install -y rsync && \  
apt-get clean  
RUN rm -rf /app/*  
RUN curl -L -O http://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz && \  
tar --strip 1 -xzf piwik-${PIWIK_VERSION}.tar.gz && \  
rm piwik-${PIWIK_VERSION}.tar.gz  
RUN chown -R www-data:www-data /app  
RUN chmod a+w /app/config  
RUN cp -r /app/config /app/config-orig  
  
EXPOSE 80  
VOLUME /app/config  
ADD run.sh /run.sh  
RUN chmod +x /run.sh  
CMD ["/run.sh"]  

