FROM python:3.5
MAINTAINER Josh Mandel

# Install required packages
RUN apt-get update
RUN apt-get install -y \
    xvfb unzip \
    redis-server \
    supervisor

#========
# Firefox
#========
ENV FIREFOX_VERSION 45.0.2
# Install iceweasel so that we have all the firefox dependencies
RUN apt-get install -y iceweasel \
    && apt-get purge -y iceweasel
# Install the firefox binary
RUN wget --no-verbose -O /tmp/firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2 \
    && rm -rf /opt/firefox \
    && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
    && rm /tmp/firefox.tar.bz2 \
    && mv /opt/firefox /opt/firefox-$FIREFOX_VERSION \
    && ln -fs /opt/firefox-$FIREFOX_VERSION/firefox /usr/bin/firefox

# Clean up now that we're done
RUN apt-get clean

# Install the app
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN  pip install --no-cache-dir -r requirements.txt
COPY . /usr/src/app

ENV FLASK_APP "/usr/src/app/app.py"
ENV FLASK_SECRET_KEY "ssssssssssh"
ENV SQLALCHEMY_DATABASE_URI "sqlite:///db/db.sqlite3"
ENV BLOOM_FILTER_URL https://s3.amazonaws.com/fhir-code-validation/codes.bf

CMD supervisord -c supervisord.conf
