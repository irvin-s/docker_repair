# GGCOM - Docker - OpenZWave v201509141444
# Louis T. Getterman IV (@LTGIV)
# www.GotGetLLC.com | www.opensour.cc/ggcom/docker/openzwave
#
# Example usage:
#
# Build
# $] docker build --tag=openzwave .
#
# Run
# $] docker run --rm --interactive --tty --device="/dev/ttyACM0:/dev/ttyUSB0" --entrypoint=/bin/bash --user=root openzwave
# $] docker run --rm --interactive --tty --device="/dev/ttyACM0:/dev/ttyUSB0" --entrypoint=/usr/local/bin/MinOZW --user=root openzwave
# $] docker run --rm --device="/dev/ttyACM0:/dev/ttyUSB0" --volume="$HOME/src/python-openzwave:/opt/pozw" openzwave "/opt/pozw/examples/hello_world.py"
#
# Thanks:
#
# Z-Wave Controller Setup on My Raspberry Pi
# http://thomasloughlin.com/z-wave-controller-setup-on-my-raspberry-pi/
#
# Z-Wave support - Home Assistant
# https://home-assistant.io/components/zwave.html
#
# Start Small: Calculating sunrise and sunset in Python
# http://michelanders.blogspot.com/2010/12/calulating-sunrise-and-sunset-in-python.html
#
# YAML parsing and Python? - Stack Overflow
# https://stackoverflow.com/questions/6866600/yaml-parsing-and-python
#
################################################################################
FROM		debian:latest
MAINTAINER	GotGet, LLC <contact+docker@gotgetllc.com>

# Initial prerequisites
USER		root
ENV			DEBIAN_FRONTEND	noninteractive
RUN			apt-get -y update && apt-get -y install \
				apt-transport-https \
				build-essential \
				curl \
				g++ \
				gcc \
				git-core \
				libbz2-dev \
				libmariadb-client-lgpl-dev \
				libmysqlclient-dev \
				libreadline-dev \
				libsqlite3-dev \
				libssl-dev \
				libudev-dev \
				libyaml-dev \
				make \
				nano \
				sudo \
				zlib1g-dev \
				pkg-config

# Create a user and reciprocal environment variables
RUN			adduser --disabled-password --gecos "" python_user
RUN			usermod -a -G dialout python_user

# Set environment variables
USER		python_user
ENV			HOME			/home/python_user
ENV			PYENV_ROOT		$HOME/.pyenv
ENV			PATH			$PYENV_ROOT/shims:$PYENV_ROOT/bin:$HOME/config:$PATH
ENV			LD_LIBRARY_PATH	/usr/local/lib64:$PATH
WORKDIR		$HOME

# Install Python
RUN			curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
RUN			curl -L https://raw.githubusercontent.com/gotget/ggcom-docker-pyenv/master/pycompiler.bash | bash -s 2
RUN			pip install --upgrade pip

################################################################################
USER		python_user
WORKDIR		$HOME

RUN			pip install Cython
RUN			pip install 'Louie>=1.1'
RUN			pip install 'urwid>=1.1.1'
RUN			pip install gevent
RUN			pip install flask-socketio

################################################################################
USER		python_user
WORKDIR		$HOME

#--------------------------------------- Supporting Modules: Databases
# Redis key-value store
RUN			pip install redis

# SQL ORM
RUN			pip install MySQL-python
RUN			pip install sqlalchemy
RUN			pip install sqlacodegen

# Mongo DB
RUN			pip install pymongo
#---------------------------------------/Supporting Modules: Databases

#--------------------------------------- Supporting Modules: Communications
# MQTT
RUN			pip install paho-mqtt

# ZeroMQ
RUN			pip install pyzmq

# Distribute execution across many Python interpreters
RUN			pip install execnet
#---------------------------------------/Supporting Modules: Communications

#--------------------------------------- Supporting Modules: Calculations
# Date calculations utility
RUN			pip install python-dateutil

# Geocoding toolbox
RUN			pip install geopy

# Astronomical computations (e.g. sunrise and sunset)
RUN			pip install pyephem

# tzinfo object for the local timezone
RUN			pip install tzlocal
#---------------------------------------/Supporting Modules: Calculations

#--------------------------------------- Supporting Modules: Utilities
# ConfigObj
RUN			pip install configobj

# YAML
RUN			pip install PyYAML

# Universal encoding detector for python 2 and 3
RUN			pip install charade

# Platform-independent file locking module
RUN			pip install lockfile
#---------------------------------------/Supporting Modules: Utilities

################################################################################
USER		python_user
WORKDIR		$HOME

# Create source directory to work out of
RUN			mkdir -pv $HOME/src/

# Clone OpenZWave
RUN			mkdir -p $HOME/src/open-zwave/
#RUN			git clone https://github.com/OpenZWave/open-zwave.git --branch "$( \
#				git ls-remote --tags https://github.com/OpenZWave/open-zwave.git | \
#				sed -e 's/^[[:space:]]*//' | \
#				grep --perl-regexp --ignore-case --only-matching '(?<=refs/tags/)v[0-9][\.0-9]*$' | \
#				sort --version-sort | \
#				tail -n 1 \
#				)" --single-branch $HOME/src/open-zwave/
# As of right now, Python-OpenZWave can't use the most recent tag, and instead needs the most recent repository.
# This is fixed in python_openzwave 0.4.x. Feel free to update
RUN			git clone https://github.com/OpenZWave/open-zwave.git $HOME/src/open-zwave/

# Compile OpenZWave
WORKDIR		$HOME/src/open-zwave/
RUN			make

# Install OpenZWave
USER		root
WORKDIR		$HOME/src/open-zwave/
RUN			make install && ldconfig /usr/local/lib64

# Install OpenZWave Device Database (https://github.com/OpenZWave/open-zwave/wiki/Adding-Devices)
USER		python_user
WORKDIR		$HOME
RUN			ln -s /usr/local/etc/openzwave $HOME/config

################################################################################
USER		python_user
WORKDIR		$HOME

# Install python_openzwave
RUN			pip install python_openzwave --install-option="--flavor=shared"

################################################################################
USER		root
WORKDIR		$HOME

# Clean-up after ourselves
RUN			apt-get -y purge \
				build-essential \
				gcc \
				git \
				make \
				pkg-config
RUN			apt-get -y autoremove

# Delete specific targets
RUN			rm -rf $HOME/src/ $HOME/.cache/pip/ /tmp/*

################################################################################
USER		root
WORKDIR		$HOME

ADD			init.bash /root/init.bash
ENTRYPOINT	[ "/bin/bash", "/root/init.bash" ]
################################################################################
