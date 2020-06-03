FROM catmaid/catmaid  
LABEL maintainer="Tom Kazimiers <tom@voodoo-arts.net>"  
# Nginx setup  
RUN rm /etc/nginx/sites-enabled/default \  
&& ln -s /home/scripts/docker/nginx-catmaid.conf /etc/nginx/sites-enabled/  
  
RUN service postgresql restart  
RUN service nginx restart  
  
ENTRYPOINT ["/home/scripts/docker/catmaid-entry.sh"]  
  
EXPOSE 80  
WORKDIR /home/django/projects  
CMD ["standalone"]  

