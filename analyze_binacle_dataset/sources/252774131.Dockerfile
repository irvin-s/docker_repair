FROM octohost/jekyll-nginx  
  
RUN gem install kramdown  
  
ENV LANGUAGE en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LC_ALL en_US.UTF-8  
  
ADD . /srv/www/  
  
ADD _config_docker.yml /srv/www/_config.yml  
  
RUN jekyll build  
  
EXPOSE 80  
  
ADD nginx.conf /etc/nginx/nginx.conf  
ADD default /etc/nginx/sites-available/default  
  
CMD nginx  
  

