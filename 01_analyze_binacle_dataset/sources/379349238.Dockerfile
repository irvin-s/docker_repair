FROM qusic/theos
ENV SHELL /bin/bash
RUN apt-get update \
 && apt-get install -y git ruby \
 && gem install twine
