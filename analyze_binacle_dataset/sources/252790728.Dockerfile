FROM nginx  
COPY default.conf.template /etc/nginx/conf.d/default.conf.template  
COPY run.sh /run.sh  
ENTRYPOINT ["/run.sh"]  
CMD [""]

