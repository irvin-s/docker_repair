FROM agideo/ruby:2.3-f  
  
ENV RAILS_ENV=production  
ENV SECRET_KEY_BASE=61de0a139d3c55461c  
RUN set -ex \  
&& cd /opt/ \  
&& curl -L -O https://github.com/alvin2ye/brimir/archive/0.7.3b.zip \  
&& apt-get update \  
&& apt-get install unzip \  
&& unzip 0.7.3b.zip \  
&& mv brimir-0.7.3b brimir \  
&& rm -rf 0.7.3b.zip \  
&& cd brimir \  
&& bundle install \  
&& bin/rake assets:precompile  
  
COPY app/database.yml /opt/brimir/config/database.yml  
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf  
COPY app/boot.bash /opt/brimir/boot.bash  
COPY docker/app.conf /etc/supervisor/conf.d/app.conf  
  
WORKDIR /opt/brimir  

