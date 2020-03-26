FROM python:2

ENV ENVIRONMENT prod
ENV NUM_WORKERS 1

WORKDIR /usr/src

RUN apt-get update \
  && apt-get install -y libopenblas-dev \
  && apt-get clean

RUN pip install --no-cache-dir Theano==1.0.2 numpy==1.14.5 gensim==3.5.0

RUN echo "[global]\nfloatX = float32" >> ~/.theanorc
RUN echo "[blas]\nldflags = -lblas -lgfortran" >> ~/.theanorc

EXPOSE 8000
