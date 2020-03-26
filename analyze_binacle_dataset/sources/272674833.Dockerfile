FROM gcr.io/tensorflow/tensorflow

RUN apt-get update && apt-get install -y graphviz \
  && pip install keras pydot graphviz

COPY notebooks /notebooks/keras/

CMD ["/run_jupyter.sh", "--allow-root"]
