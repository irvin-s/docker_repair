FROM python:3.5

COPY entrypoint /usr/local/bin/entrypoint

RUN mkdir -p /usr/src/app
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# Create django user, will own the Django app
RUN useradd -s /bin/bash --uid 1000 --home-dir /srv/django django

COPY ./src/requirements.txt /srv/django/

WORKDIR /srv/django
RUN chown -R django:django .
USER django

RUN /bin/bash -c "virtualenv /srv/django/.env \
    && source /srv/django/.env/bin/activate \
	&& pip install -r /srv/django/requirements.txt"


EXPOSE 8000

# Add code
COPY ./src /srv/django
USER root
RUN chown -R django:django .
USER django

ENTRYPOINT ["/usr/local/bin/entrypoint"]
# Execute start script
CMD ["uwsgi", "/srv/django/uwsgi.ini"]
