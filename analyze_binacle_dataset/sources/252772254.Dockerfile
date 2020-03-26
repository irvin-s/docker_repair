FROM redmine:latest  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
gcc \  
libmagickcore-dev \  
libmagickwand-dev \  
libmysqlclient-dev \  
libpq-dev \  
libsqlite3-dev \  
make \  
patch \  
&& rm -rf /var/lib/apt/lists/*  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
EXPOSE 3000  
CMD ["rails", "server", "-b", "0.0.0.0"]  
  

