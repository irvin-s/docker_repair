FROM quantopian/zipline
ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# update, upgrade, and install packages
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y apt-utils \
    && apt-get install -y nano less make \
    && apt-get install -y python-dev python3-dev

# configure apt-utils (fixes warnings)
RUN dpkg-reconfigure apt-utils

# install and upgrade pip
RUN wget -P /tmp https://bootstrap.pypa.io/get-pip.py
RUN python2 /tmp/get-pip.py
RUN python2 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade pip

# install ipython for python 2
RUN python2 -m pip install ipython

# set some useful defaults
RUN echo "alias ls='ls --color'" >> /etc/bash.bashrc
RUN echo "alias grep='grep --color=auto'" >> /etc/bash.bashrc

# install package and dev requirements for python 2/3 (editable)
COPY . /app
RUN python2 -m pip install -r /app/requirements/dev.txt
RUN python2 -m pip install -e /app
RUN python3 -m pip install -r /app/requirements/dev.txt
RUN python3 -m pip install -e /app

# stage the entrypoint
COPY ./compose/stockbot/entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r//' /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
