FROM tensorflow/tensorflow  
  
LABEL de.innoq.tensorflow-models.maintainer="Bjoern.Makowe@innoq.com" \  
de.innoq.tensorflow-models.vendor="innoQ Deutschland GmbH" \  
de.innoq.tensorflow-models.name="Tensorflow models" \  
de.innoq.tensorflow-models.description="Image for testing Tensorflow models" \  
de.innoq.tensorflow-models.version="1.0"  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
git \  
protobuf-compiler \  
python-pil \  
python-lxml \  
&& pip install pillow \  
&& pip install lxml \  
&& pip install matplotlib \  
&& git clone https://github.com/tensorflow/models.git \  
&& cd models \  
&& python setup.py build install \  
&& python slim/setup.py build install \  
&& protoc object_detection/protos/*.proto --python_out=. \  
&& export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
ENV PYTHONPATH=$PYTHONPATH:/notebooks/models:/notebooks/models/slim  
  
VOLUME "/notebooks"  
  
CMD ["/run_jupyter.sh", "--allow-root"]

