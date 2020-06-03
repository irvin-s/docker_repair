# Nginx to redirect http -> https
FROM rounds/10m-nginx

ADD files/etc /etc

# Only http port is used
EXPOSE 80
