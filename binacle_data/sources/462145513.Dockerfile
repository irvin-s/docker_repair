FROM alpine:3.5
MAINTAINER Ilkka Laukkanen <ilkka.laukkanen@futurice.com>

# compiler and libs required to install pypi packages
RUN apk --no-cache add build-base python python-dev python3 python3-dev py-virtualenv ca-certificates libffi-dev libxml2-dev libxslt-dev nodejs cairo-dev pango-dev postgresql libpq postgresql-dev gdk-pixbuf gdk-pixbuf-dev libjpeg-turbo libjpeg-turbo-dev imagemagick

# set up work area
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# create virtualenvs
RUN virtualenv -p /usr/bin/python3 /usr/src/app/py3env
RUN virtualenv -p /usr/bin/python2 /usr/src/app/py2env

# deps install step: change infrequently, satisfied from cache
COPY requirements.txt /usr/src/app/
RUN source py3env/bin/activate && pip install --no-cache-dir -r requirements.txt
COPY package.json /usr/src/app/
RUN source py2env/bin/activate && npm install

# deploy and build app code
COPY . /usr/src/app/
RUN npm run build-js && npm run build-sass

# deploy fonts
RUN mkdir -p /usr/share/fonts/local
COPY ./fonts/* /usr/share/fonts/local/
RUN fc-cache /usr/share/fonts/local

# expose port
EXPOSE 8000

# set up runtime
CMD ["sh", "-c", "source py3env/bin/activate && python main.py"]
