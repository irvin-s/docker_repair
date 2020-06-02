FROM fcoelho/python27

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

RUN	cd /tmp && \
	curl -O https://raw.githubusercontent.com/pypa/pip/master/contrib/get-pip.py && \
	/opt/python27/bin/python /tmp/get-pip.py && \
	/opt/python27/bin/pip install virtualenv && \
	rm -rf /tmp/* && yum clean all
