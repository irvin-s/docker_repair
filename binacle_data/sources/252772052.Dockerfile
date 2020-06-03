FROM debian:stretch  
  
ENV TZ=Europe/Madrid  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  
  
RUN apt-get update && apt-get install -y apache2 \  
libapache2-mod-wsgi \  
build-essential \  
python \  
python-dev \  
python-pip \  
libmariadbclient-dev \  
&& apt-get clean \  
&& apt-get autoremove -y --purge \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY start.sh /start.sh  
RUN chmod 0744 /start.sh  
  
RUN mkdir /app && \  
mkdir -p /var/log/stats/academico && \  
chown www-data.www-data /var/log/stats/academico  
  
COPY apache-django.conf /etc/apache2/sites-available/apache-django.conf  
RUN a2ensite apache-django  
RUN a2enmod headers  
RUN a2enmod rewrite  
  
RUN a2dissite 000-default  
  
EXPOSE 80  
WORKDIR /app  
CMD ["/start.sh"]

