FROM python:2.7
MAINTAINER Shannon Black <shannon@ilovezoona.com>

RUN apt-get update && apt-get install -qq -y telnetd
RUN apt-get install -qq -y telnet

COPY ./ /jasminwebpanel
WORKDIR /jasminwebpanel

RUN pip install psycopg2
RUN pip install -r requirements.pip

#RUN ./manage.py migrate
## RUN ./manage.py createsuperuser
#RUN echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'pass')" | python manage.py shell
#RUN ./manage.py collectstatic --noinput

COPY ./docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ./manage.py runserver 0.0.0.0:8000