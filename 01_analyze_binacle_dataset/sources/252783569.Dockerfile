FROM tensorflow/tensorflow:1.6.0  
  
RUN apt-get update \  
&& apt-get install -y python-tk protobuf-compiler python-lxml git\  
&& pip install Cython \  
&& pip install git+https://github.com/crowdai/coco.git#subdirectory=PythonAPI  
  
COPY . /tensorflow/models  
  
RUN cd /tensorflow/models \  
&& protoc object_detection/protos/*.proto --python_out=. \  
&& python setup.py sdist \  
&& (cd slim && python setup.py sdist)  
  
ENV PYTHONPATH=$PYTHONPATH:/tensorflow/models:/tensorflow/models/slim  

