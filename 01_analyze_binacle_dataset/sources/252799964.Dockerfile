FROM alpine:3.6  
# Install python 3, uwsgi, pip, node and git  
RUN apk update && apk upgrade && apk add --no-cache --update \  
uwsgi \  
uwsgi-python3 \  
py-pip \  
nodejs \  
git \  
postgresql-dev\  
py3-psycopg2 \  
&& rm -rf /var/cache/apk/* # Delete the cache folder to save some space

