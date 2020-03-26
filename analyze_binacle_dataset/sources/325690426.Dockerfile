# Frontend asset builder
FROM node:8-stretch as frontend

WORKDIR /opt/frontend
COPY package.json yarn.lock /opt/frontend/

RUN yarn && \
	yarn cache clean && \
	true

COPY ./design/ /opt/frontend/design/

RUN yarn run build
CMD ["yarn", "run", "watch"]

# Django application
FROM python:3.7-stretch AS django

WORKDIR /opt/my-web-app/

RUN apt-get update \
    && apt-get install \
        --no-install-recommends --yes \
        build-essential libpq-dev \
    && true

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt \
    && true

COPY ./mywebapp /opt/my-web-app/mywebapp
COPY ./deploy /opt/my-web-app/deploy
COPY ./manage.py /opt/my-web-app/manage.py
COPY --from=frontend /opt/frontend/static /opt/my-web-app/mywebapp/static

ENV PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    PYTHONDONTWRITEBYTECODE=1 \
    DJANGO_SETTINGS_MODULE=deploy.settings

CMD ["/opt/my-web-app/deploy/run.sh"]
