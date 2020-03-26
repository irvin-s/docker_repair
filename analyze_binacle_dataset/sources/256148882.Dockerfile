from  python:3.7

COPY . /app

RUN pip install pipenv

WORKDIR app

RUN ./setup.sh

RUN pip install paho-mqtt

CMD pipenv run flask run & python3 /app/mqtt/mqttmain.py & python3 /app/mqtt/fakejardin.py
