FROM python:2.7

# Docker build context must be the the root of project (the folder with SickBeard.py)
COPY . /src/sickbeard

WORKDIR /src/sickbeard
RUN rm -rf /src/sickbeard/docker/data

RUN pip install --no-cache-dir -r ./requirements.txt

VOLUME ["/src/sickbeard/runtime", "/tvshows", "/downloads"]

CMD [ "python", "./SickBeard.py", "--config=/src/sickbeard/runtime/config.ini", "--datadir=/src/sickbeard/runtime", "--addr=0.0.0.0", "--nolaunch"]