FROM andrewosh/binder-python-3.5:latest
MAINTAINER Andrey Ustyuzhanin andrey.u@gmail.com
EXPOSE 8888

USER root
COPY install-packages.sh /tmp/
RUN /tmp/install-packages.sh

COPY install-conda.sh environment.yaml /tmp/
RUN cd /tmp && /tmp/install-conda.sh
 
SHELL ["/bin/bash", "--login", "-c"]

COPY install-jupyter.sh /tmp/
RUN /tmp/install-jupyter.sh

# hyperopt supporting function serialization

RUN cd /tmp && \
	git clone https://github.com/hyperopt/hyperopt.git && cd hyperopt && git pull origin pull/288/head && \
	pip install --upgrade . && \
	cd /tmp; rm -rf hyperopt

USER main
#COPY start_jupyter_or_everware.sh /usr/local/bin/
#CMD ["/bin/bash", "--login", "-c", "/usr/local/bin/start_jupyter_or_everware.sh"]
