FROM pydata:latest

RUN pip3 install git+git://github.com/Theano/Theano.git
RUN pip3 install git+https://github.com/fchollet/keras.git

EXPOSE 8888
