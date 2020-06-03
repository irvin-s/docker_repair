FROM ubuntu:14.04
MAINTAINER Peter Lauri <peterlauri@gmail.com>

#######################################################
# OS Updates and Python packages
#######################################################

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y

RUN apt-get install -y python-dev python-setuptools nginx supervisor libpq-dev postgresql-client
RUN easy_install pip
RUN pip install --upgrade pip
RUN pip install virtualenv

#######################################################
# Setting up project virtual environment
#######################################################

ADD requirements /requirements
RUN virtualenv /app/.vedocker
RUN /app/.vedocker/bin/pip install -r /requirements/production.txt

#######################################################
# Adding application code
#######################################################

ADD {{ cookiecutter.source_root }} /app/
RUN /app/.vedocker/bin/python /app/manage.py collectstatic --noinput

#######################################################
# Setting up uWSGI with supervisor
#######################################################

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD docker/supervisor_django.conf /etc/supervisor/conf.d/app.conf
ADD docker/nginx.conf /etc/nginx/sites-available/app.conf

RUN ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled
RUN rm -f /etc/nginx/sites-enabled/default


EXPOSE 80

CMD ["supervisord", "-n"]
