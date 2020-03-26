FROM dockerfile/ubuntu-desktop
MAINTAINER Jim White <mailto:jimwhite@uw.edu>

# Need this for vncserver
ENV USER root
ENV HOME /root
ENV DISPLAY :1

EXPOSE 5901

WORKDIR /root

COPY userfiles /root

# Install Lynx so there is a way to get web content for dl and copy&paste.

# We won't be training the models so we don't need libLBFGS.

RUN apt update && \
	apt-get -y install lynx firefox \
		python-setuptools python-dev python-tk \
		swig flex libboost-dev && \
	easy_install pip && \
	pip install -U numpy && \
	pip install -U nltk && \
	pip install -U jpype1 && \
	pip install -U PyStanfordDependencies && \
	pip install -U asciitree

# bllipparser not installed via pip so we'll use the latest code

# To clean up the APT files we could remove them like this:
#	rm -rf /var/lib/apt/lists/*	
	
RUN git clone https://github.com/BLLIP/bllip-parser.git && \
	cd bllip-parser && \
	make && \
	./setup.py install
	
# Start me with:
# 	docker run -it --rm -p 5901:5901 bllip/bllip-parser-python

# Then at the prompt you can start VNC if you want graphics:
#	./runvnc.sh
# That will prompt you for a password and start up the VNC server.

# On a Mac you can use the builtin VNC client using open:
# 	open vnc://192.168.59.103:5901
# That is the default VirtualBox IP address.  You can display it with this command:
#	boot2docker ip
# Which means you could also do this:
# 	open vnc://`boot2docker ip`:5901
# You can also enter `vnc://192.168.59.103:5901` in the location bar in Safari.

CMD [ "/bin/bash", "-login" ]
