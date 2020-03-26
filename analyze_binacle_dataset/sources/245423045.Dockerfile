FROM python:3.6-alpine

# matplotlib, numpy require these
# pkgconfig build-base freetype-dev libpng-dev openblas-dev
RUN apk add --no-cache \
  pkgconfig build-base freetype-dev libpng-dev openblas-dev \
  sqlite

# first just copy over the dependency files
WORKDIR /app
COPY requirements.txt .

# now install deps
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install gunicorn

# create a directory to be mapped to the host which will store the database
# RUN apt-get update && apt-get install sqlite3
RUN mkdir /db

# now copy over the application
# changing the app will not trigger a rebuild of the deps
COPY . .

CMD [ "gunicorn", "-w", "4", "wsgi:application" ]
