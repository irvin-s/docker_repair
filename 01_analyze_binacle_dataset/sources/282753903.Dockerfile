FROM debian:stable-slim
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y libleveldb1v5 libexpat1 libgmp10 git python python-pip wget zip libpq-dev

#RUN wget https://www.adjoint.io/release/uplink_1.1_amd64.deb
COPY uplink_1.2_amd64.deb .
RUN apt install -y ./uplink_1.2_amd64.deb

COPY uplink-explorer/uplink_explorer /usr/src/app/uplink_explorer
COPY uplink-explorer/requirements.txt /usr/src/app/requirements.txt
COPY uplink-explorer/app.py /usr/src/app/app.py
RUN mkdir /usr/src/app/keys

COPY config-1.2.zip /
RUN unzip /config-1.2.zip
RUN pip install -r requirements.txt

ENTRYPOINT bash -c "uplink chain init --test -k config/validators/auth0/key & READONLY=FALSE ENV=DEV RPC_HOST=localhost HOST=0.0.0.0 python app.py"
