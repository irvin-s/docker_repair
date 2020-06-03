###########################################################################
# Copyright 2017 ZT Prentner IT GmbH (www.ztp.at)
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
###########################################################################

FROM ubuntu:16.04
MAINTAINER ZTP.at

# Runtime deps
RUN apt-get update && \
	apt-get install -y python-virtualenv mesa-common-dev \
	libgl1-mesa-dev libssl-dev libpython2.7-dev libzbar-dev \
	build-essential gettext libffi-dev

# APK build deps
RUN dpkg --add-architecture i386 && apt-get update && \
	apt-get install -y default-jdk git unzip wget libncurses5:i386 \
	libstdc++6:i386 zlib1g:i386 autoconf

# for GUI
RUN apt-get install -y openssh-server
EXPOSE 22

# user setup
RUN useradd -m rksv && echo 'rksv:rksv' | chpasswd && \
	chsh rksv -s /bin/bash
RUN apt-get install -y sudo && echo 'rksv ALL=(root) NOPASSWD: ALL' > \
	/etc/sudoers.d/rksv && chmod 440 /etc/sudoers.d/rksv

# download A-SIT Plus demo & verification tool
RUN cd /home/rksv && wget https://github.com/BMF-RKSV-Technik/at-registrierkassen-mustercode/releases/download/V1.0.0/regkassen-demo-1.0.0.zip && \
	unzip regkassen-demo-1.0.0.zip && chown -R rksv:rksv regkassen-demo-1.0.0*

# setup repo
COPY . /home/rksv/pyreg
RUN chown -R rksv:rksv /home/rksv/pyreg && \
	chmod -R u+rwX,go+rX /home/rksv/pyreg

# some preparation
RUN cd /home/rksv/pyreg && su -c 'make env' rksv
RUN cd /home/rksv/pyreg && \
	su -c 'source .pyenv/bin/activate && make compile-trans' rksv
RUN echo 'source ~/pyreg/.pyenv/bin/activate' >> /home/rksv/.profile

USER rksv
WORKDIR /home/rksv/pyreg
ENTRYPOINT /bin/bash -l
