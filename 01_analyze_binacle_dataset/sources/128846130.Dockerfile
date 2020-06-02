FROM python:3.6-alpine

MAINTAINER Robert Wimmer <docker@tauceti.net>

# Install Python requests module
RUN pip3 install requests

# Add a group/user used to execute pinlinkfetcher
RUN addgroup pdown; \
    adduser -s /bin/bash -D -G pdown -h /home/pdown pdown

# Locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Copy files to container.
ADD pindownloadr2.py /usr/local/bin/pindownloadr2.py

# Set $HOME since Docker defaults to / as $HOME directory for all users 
ENV HOME /home/pdown 

# Work as pdown user from now on
USER pdown

WORKDIR /home/pdown

ENTRYPOINT ["/usr/local/bin/pindownloadr2.py"]
CMD ["-h"]
