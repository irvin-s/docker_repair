FROM python:2.7.9

ENV APP=/var/www/{{cookiecutter.project_name}}
ENV BUILDOUT=$APP/bin/buildout
ENV BUILDOUT_OPTIONS=

RUN mkdir -p $APP
WORKDIR $APP
COPY . $APP
RUN $APP/docker/run.sh && rm -Rf $APP/parts/node*

ENTRYPOINT ["/var/www/{{cookiecutter.project_name}}/bin/django-serve"]
