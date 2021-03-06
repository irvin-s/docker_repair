FROM gcr.io/tensorflow/tensorflow:latest
MAINTAINER Vincent Vanhoucke <vanhoucke@google.com>
RUN pip install scikit-learn pyreadline Pillow
RUN rm -rf /notebooks/*
ADD *.ipynb /notebooks/
WORKDIR /notebooks
CMD ["/run_jupyter.sh"]
