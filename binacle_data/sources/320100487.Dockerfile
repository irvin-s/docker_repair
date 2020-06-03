FROM petronetto/miniconda-alpine

RUN conda install numpy pip tensorflow python=3.6 --yes -c conda-forge
#RUN apk add --update python python-dev gfortran py-pip build-base py-numpy
ENV PATH=/opt/conda/bin/:${PATH}
RUN pip install --no-cache-dir flask gevent
RUN mkdir /imagenet
COPY inception-2015-12-05.tgz /imagenet
RUN mkdir /images
COPY images /images
RUN mkdir /actionProxy action
COPY classify_image.pipe.py /
COPY ep.tf.sh /action/exec
COPY actionproxy.py3.py /actionProxy/actionproxy.py
CMD ["bin/sh","-c","cd actionProxy && python -u actionproxy.py"]                                                                
