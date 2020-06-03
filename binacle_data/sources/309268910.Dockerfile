FROM codeforafrica/hurumap:0.6.2

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/74.0.3729.6/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# set display port to avoid crash
ENV DISPLAY=:99

# Set env variables used in this Dockerfile
# HURUmap App and Django settings
ENV HURUMAP_APP=takwimu
ENV DJANGO_SETTINGS_MODULE=takwimu.settings
# Local directory with project source
ENV APP_SRC=.
# Directory in container for all project files
ENV APP_SRVHOME=/src
# Directory in container for project source files
ENV APP_SRVPROJ=/src/takwimu

# Add application source code to SRCDIR
ADD $APP_SRC $APP_SRVPROJ

# Copy entrypoint script into the image
WORKDIR $APP_SRVPROJ

# Install app dependencies
COPY ./requirements.txt /
RUN pip install -q -r /requirements.txt
