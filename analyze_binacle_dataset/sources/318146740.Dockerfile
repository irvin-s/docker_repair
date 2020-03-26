FROM python:2
ARG user=exraidbot
ARG group=exraidbot
ARG uid=1000
ARG gid=1000
ARG EXRAIDBOT_HOME=/opt/exraidbot

RUN apt-get update && apt-get -y install libtesseract3 tesseract-ocr-eng
RUN pip install opencv-python-headless numpy imutils python-dateutil pyocr disco-py fuzzywuzzy

RUN mkdir -p $EXRAIDBOT_HOME/plugins \
    && mkdir -p $EXRAIDBOT_HOME/config \
    && chown ${uid}:${gid} $EXRAIDBOT_HOME \
    && groupadd -g ${gid} ${group} \
    && useradd -d "$EXRAIDBOT_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

VOLUME $EXRAIDBOT_HOME

COPY config.json $EXRAIDBOT_HOME
COPY cv2utils.py $EXRAIDBOT_HOME
COPY pokediscord.py $EXRAIDBOT_HOME
COPY pokeocr.py $EXRAIDBOT_HOME
COPY topleft.png $EXRAIDBOT_HOME
COPY bottom.png $EXRAIDBOT_HOME
COPY config/exraid.json $EXRAIDBOT_HOME/config/
COPY plugins/exraidplugin.py $EXRAIDBOT_HOME/plugins/
COPY plugins/__init__.py $EXRAIDBOT_HOME/plugins/

USER $user
WORKDIR $EXRAIDBOT_HOME
CMD [ "python", "-m", "disco.cli", "--config",  "config.json" ]
