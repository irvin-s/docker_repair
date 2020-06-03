FROM bgross27/neuro_analysis  
  
USER root  
  
RUN pip install python-dateutil  
RUN apt-get install -y libjpeg62  
RUN mkdir -p /var/www/.ssh && \  
echo "Host *\n\tStrictHostKeyChecking no" > /var/www/.ssh/config && \  
chown www-data /var/www/.ssh/config && \  
chmod 400 /var/www/.ssh/config  
  
USER www-data  
CMD /usr/local/bin/padre_demon.py  

