FROM python:3

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . .

CMD [ "python", "./hello_world.py" ]
