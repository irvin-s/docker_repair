FROM ubuntu:18.04

EXPOSE 5000

RUN apt-get update && apt-get install -qfy \
    curl \
    git \
    nodejs \
    npm \
    python-pip \
    python-dev \
    ipython \
    libpq-dev \
    postgresql-server-dev-all

WORKDIR /build_docker

COPY docker/explorer/requirements.txt /build_docker/requirements.txt
RUN pip install -r requirements.txt --require-hashes

# upgrade node (need to downgrade npm first)
RUN npm install -g npm@4.6.1
RUN npm install -g n
RUN n 10.0.0
RUN npm install -g npm@6.0.0

COPY docker/explorer/package.json /build_docker/gui_alt/package.json
RUN cd gui_alt && npm i --production
COPY gui2/package.json /build_docker/gui2/package.json
COPY gui2/package-lock.json /build_docker/gui2/package-lock.json
RUN cd gui2 && npm i --production

COPY mintools /build_docker/mintools
COPY explorer /build_docker/explorer
COPY setup.py /build_docker/setup.py
RUN python /build_docker/setup.py develop

COPY webflask /build_docker/webflask
COPY gui_alt /build_docker/gui_alt
COPY gui2 /build_docker/gui2
RUN cd gui2 && npm run build

ARG ENV_NAME
COPY docker/$ENV_NAME/conf/API_AVAILABLE.json /build_docker/docker/conf/API_AVAILABLE.json
COPY docker/$ENV_NAME/conf/AVAILABLE_CHAINS.json /build_docker/docker/conf/AVAILABLE_CHAINS.json
COPY docker/$ENV_NAME/conf/RPC_ALLOWED_CALLS.json /build_docker/docker/conf/RPC_ALLOWED_CALLS.json
COPY docker/$ENV_NAME/conf/explorer.proc /build_docker/docker/conf/explorer.proc
COPY docker/$ENV_NAME/conf/explorer.env /build_docker/docker/conf/explorer.env
CMD honcho start -e docker/conf/explorer.env -f docker/conf/explorer.proc
