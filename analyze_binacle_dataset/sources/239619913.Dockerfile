FROM python:2.7.8
MAINTAINER means88 "means88.x@gmail.com"

# Change source of apt and pip
ADD ./change_source.sh /code/change_source.sh
RUN chmod +x /code/change_source.sh
RUN /code/change_source.sh
RUN rm -f /code/change_source.sh


# Install packages
RUN apt-get update && apt-get install -y \
    git \
    libmysqlclient-dev \
    mysql-client \
    nginx \
    supervisor

RUN mkdir -p /code/log/
WORKDIR /code

# for cache
ADD ./requirements.txt /code/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Configure Nginx and uwsgi
RUN rm /etc/nginx/sites-enabled/default && \
    rm /etc/nginx/nginx.conf
ADD ./.deploy/nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./.deploy/nginx/app.conf /etc/nginx/sites-enabled/app.conf
ADD ./.deploy/supervisord.conf /etc/supervisor/conf.d/

# If use https
# ADD path/to/app.crt /etc/nginx/app.crt
# ADD path/to/app.key /etc/nginx/app.key

#RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD . /code
RUN rm -f /code/config/local_settings.py
RUN mv /code/config/prov_settings.py /code/config/local_settings.py
RUN chmod +x ./*.sh

EXPOSE 80
EXPOSE 8000
VOLUME /code/log/

CMD ["sh", "./entrypoint.sh"]


