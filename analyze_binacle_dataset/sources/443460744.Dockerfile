FROM python:2.7

WORKDIR /srv/lojban/vlasisku
RUN apt-get update
RUN apt-get -y install sudo vim flex bison

# Download and install jbofihe
RUN git clone https://github.com/lojban/jbofihe.git

WORKDIR /srv/lojban/vlasisku/jbofihe

RUN perl config.pl --prefix=/usr/local
RUN make all
RUN make install

WORKDIR /srv/lojban/vlasisku

# Download and install all the python bits
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt
RUN pip install nose  # used to run tests, hence not really a requirement

# User setup
ARG VS_USERID
ARG VS_GROUPID

COPY sudoers /etc/sudoers.d/sampre_vs

RUN groupadd -g ${VS_GROUPID} sampre_vs
RUN useradd -p '**LOCKED**' -g sampre_vs -u ${VS_USERID} -m sampre_vs

# Basic user config
USER sampre_vs
ENV TZ America/Los_Angeles
ENV LANG en_US.UTF-8
ENV HOME /home/sampre_vs 

WORKDIR /srv/lojban/vlasisku
