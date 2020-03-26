FROM rasa_local_settings

ENV RASA_DOCKER="YES" \
    RASA_HOME=/app \
    RASA_PYTHON_PACKAGES=/usr/local/lib/python2.7/dist-packages

# Run updates, install basics and cleanup
# - build-essential: Compile specific dependencies
# - git-core: Checkout git repos
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends build-essential git-core openssl libssl-dev libffi6 libffi-dev curl  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR ${RASA_HOME}

COPY . ${RASA_HOME}

# use bash always
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN pip install rasa_core

RUN pip install rasa_nlu==0.12.2

RUN pip install flask

EXPOSE 5000 5005

CMD python ./bot.py --port 5005
