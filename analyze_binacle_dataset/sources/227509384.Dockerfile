FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y \
	python \
        python-pip \
        python-scrapy \
        python-scipy \
        python-numpy \
        python-matplotlib \
        ipython-notebook
RUN pip install lasagne
COPY training /chinese
WORKDIR /chinese
EXPOSE 8888
CMD ipython notebook --ip 0.0.0.0
