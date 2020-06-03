FROM ubuntu:16.04
MAINTAINER Andrey Ustyuzhanin andrey.u@gmail.com
EXPOSE 8888

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

CMD ["/bin/bash", "--login", "-c", "/usr/local/bin/start_jupyter_or_everware.sh"]
COPY start_jupyter_or_everware.sh /usr/local/bin/

RUN pip install git+https://github.com/yandexdataschool/modelgym.git
