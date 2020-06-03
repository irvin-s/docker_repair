FROM debian:9
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV VIRTUAL_ENV=/usr/local
ENV FLASK_APP=/usr/local/src/jekylledit/jekylledit/__init__.py
WORKDIR /usr/local/src/jekylledit
EXPOSE 8000

RUN apt-get -qq update && apt-get -qq -y --no-install-recommends install \
    build-essential \
    ca-certificates \
    gettext \
    git \
    libffi-dev \
    libpq-dev \
    python3 \
    python3-dev \
    python3-venv \
    rsync \
    ssh

COPY requirements.txt /tmp/requirements.txt
RUN python3 -m venv /usr/local \
&& /usr/local/bin/pip install -r /tmp/requirements.txt

RUN git config --global push.default matching

COPY jekylledit /usr/local/src/jekylledit/jekylledit
COPY migrations /usr/local/src/jekylledit/migrations
