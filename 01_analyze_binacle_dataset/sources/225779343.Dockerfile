FROM nginx:latest
# Remove default nginx configs.
RUN rm /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/*.conf
RUN if [ -d '/etc/nginx/sites-enabled' ]; then rm -rf /etc/nginx/sites-enabled; fi
## Remove default nginx logs.
##RUN rm -f /var/log/nginx/*.log

# Add configuration files
COPY ./config/nginx.conf /etc/nginx/
#COPY ./sites-enabled/app.default.conf /etc/nginx/sites-enabled/

EXPOSE 80 443
