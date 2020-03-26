FROM python:3.6-jessie
LABEL maintainer="PolySwarm Developers <info@polyswarm.io>"

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
        jq \
        libgmp-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./

RUN set -x && pip install --no-cache-dir -r requirements.txt
RUN set -x && pip install gunicorn

COPY . .
RUN set -x && pip install .

# You can set log format and level in command line by e.g. `polyswarmd.wsgi:app(log_format='text', log_level='WARNING')`
CMD ["gunicorn", "--bind", "0.0.0.0:31337", "-k", "flask_sockets.worker", "-t", "600", "-w", "4", "polyswarmd.wsgi:app()"]
