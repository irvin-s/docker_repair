FROM pyda-python2.7

RUN pip install git+git://github.com/Theano/Theano.git
RUN pip install git+https://github.com/fchollet/keras.git

EXPOSE 8888
