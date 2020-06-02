FROM codelittinc/nginx
RUN apt-get update
RUN apt-get install -y --fix-missing letsencrypt
