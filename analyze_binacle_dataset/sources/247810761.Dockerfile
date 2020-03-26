FROM reverbrain/xenial-dev

#RUN	echo "deb http://repo.reverbrain.com/trusty/ current/amd64/" > /etc/apt/sources.list.d/reverbrain.list && \
#	echo "deb http://repo.reverbrain.com/trusty/ current/all/" >> /etc/apt/sources.list.d/reverbrain.list && \
#	apt-get install -y curl tzdata && \
#	cp -f /usr/share/zoneinfo/posix/W-SU /etc/localtime && \
#	curl http://repo.reverbrain.com/REVERBRAIN.GPG | apt-key add - && \
#	apt-get update && \
#	apt-get upgrade -y && \
#	apt-get install -y git g++ liblz4-dev libsnappy-dev zlib1g-dev libbz2-dev libzstd-dev libgflags-dev libjemalloc-dev && \
#	apt-get install -y cmake debhelper cdbs devscripts && \
#	apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-program-options-dev && \
#	apt-get install -y libmsgpack-dev libswarm3-dev libthevoid3-dev ribosome-dev && \
#	git config --global user.email "zbr@ioremap.net" && \
#	git config --global user.name "Evgeniy Polyakov"

#RUN	cd /tmp && \
#	git clone https://github.com/facebook/rocksdb && \
#	cd rocksdb && \
#	PORTABLE=1 make shared_lib && \
#	make INSTALL_PATH=/usr install-shared && \
#	echo "Rocksdb package has been updated and installed"

RUN	cd /tmp && \
	rm -rf ribosome && \
	git clone https://github.com/reverbrain/ribosome && \
	cd ribosome && \
	git branch -v && \
	dpkg-buildpackage -b && \
	dpkg -i ../ribosome*.deb && \
	echo "Ribosome package has been updated and installed" && \

	cd /tmp && \
	rm -rf greylock && \
	git clone https://github.com/reverbrain/greylock && \
	cd greylock && \
	git branch -v && \
	dpkg-buildpackage -b && \
	dpkg -i ../greylock_*.deb ../greylock-dev_*.deb && \
	echo "Greylock package has been updated and installed" && \
    	rm -rf /var/lib/apt/lists/*

EXPOSE 8080 8181 8111
