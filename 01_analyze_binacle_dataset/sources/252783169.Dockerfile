FROM seif/docker-mono-fastcgi-nginx:latest  
MAINTAINER srdjan.bozovic@live.com  
RUN apt-get update && apt-get -y install unzip  
ADD https://dockersa.blob.core.windows.net/drop/GeekQuiz.zip /tmp/GeekQuiz.zip  
RUN unzip /tmp/GeekQuiz.zip -d /tmp/www/ && \  
site_dir=$(dirname "`find /tmp/www/ -d -name 'Web.config' | tail -n 1`") && \  
rm -r /var/www && \  
mv -v "$site_dir" /var/www && \  
rm -r /tmp/*  
ADD runit_bootstrap_ext /usr/sbin/runit_bootstrap_ext  
CMD ["/usr/sbin/runit_bootstrap_ext"]  

