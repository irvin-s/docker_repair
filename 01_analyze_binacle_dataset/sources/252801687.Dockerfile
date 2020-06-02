FROM ruby:2.3-slim  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends sqlite3 \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends build-essential libsqlite3-dev \  
&& gem install mailcatcher \  
&& apt-get purge -y --auto-remove build-essential libsqlite3-dev \  
&& rm -rf /var/lib/apt/lists/*  
  
EXPOSE 1025 1080  
  
CMD [ "mailcatcher", "-f", "--ip", "0.0.0.0" ]  

