FROM python:3.6.4-stretch  
  
ENV CORE_USER primo  
  
RUN useradd -ms /bin/bash ${CORE_USER}  
  
USER root  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
git \  
make \  
cmake \  
g++ \  
gcc \  
gfortran \  
build-essential \  
libatlas-base-dev \  
libblas3 \  
libopenblas-dev \  
liblapack-dev \  
cython \  
python3-dev \  
libyaml-dev  
  
RUN pip install --upgrade pip \  
&& pip install numpy==1.13.3 \  
&& pip install scipy==1.0.0 \  
&& pip install pybind11==2.2.1  
  
RUN git clone --recursive https://github.com/dmlc/xgboost \  
&& cd xgboost \  
&& git reset --hard 602b34ab914da7830d632ca8079ebffc3bd608f0 \  
&& make -j4 \  
&& cd python-package; python setup.py install  
  
  
RUN pip install setuptools==36.2.7 \  
pytest==3.3.0 \  
joblib==0.11 \  
pandas==0.22.0 \  
gensim==3.4.0 \  
nltk==3.2.5 \  
stop-words \  
PyStemmer==1.3.0 \  
scikit-learn==0.19.1 \  
spacy==1.7.5 \  
datasketch==1.2.0 \  
psutil==5.2.2 \  
memory_profiler==0.45 \  
ruamel.yaml==0.14.11 \  
scikit-optimize==0.5.1 \  
pyemd==0.4.2 \  
sacred==0.7.2 \  
lightgbm==2.1.0  
  
RUN git clone https://github.com/facebookresearch/fastText.git \  
&& cd fastText \  
&& pip install .  
  
RUN chmod -R 777 /usr/local/lib/python3.6/site-packages  
RUN chmod -R 777 /usr/local/lib/python3.6/site-packages/spacy  
  
CMD ["bash"]  

