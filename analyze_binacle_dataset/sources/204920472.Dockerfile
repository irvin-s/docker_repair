FROM python:3.6-alpine

LABEL maintainer="http://www.hasadna.org.il/"

ENV APP_NAME "server"
ENV APP_USER "app"
ENV HOME /home/$APP_USER
ENV APP_DIR $HOME/$APP_NAME

RUN set -ex \
	&& apk add --no-cache --virtual .fetch-deps \
		postgresql-dev build-base

WORKDIR $APP_DIR
COPY requirements.txt $APP_DIR/requirements.txt
RUN pip --no-cache-dir install -r requirements.txt

COPY . $APP_DIR

RUN chmod +x entrypoint.sh

EXPOSE 80
CMD ["/home/app/server/entrypoint.sh"]
