FROM nginx:1.13.8  
  
COPY --from=410labs/graphite:1.1.1 /opt/graphite/static /opt/graphite/static  
COPY --from=410labs/graphite:1.1.1 \  
/usr/local/lib/python2.7/dist-packages/django/contrib/admin/static/ \  
/usr/local/lib/python2.7/dist-packages/django/contrib/admin/static/  
  
COPY site.conf /etc/nginx/conf.d/default.conf  

