FROM deepgnosis/tensorflow-install:latest  
  
RUN source activate keras \  
&& pip install git+git://github.com/pykalman/pykalman.git \  
&& pip install git+git://github.com/fchollet/keras.git --no-deps \  
&& pip install --no-deps git+https://github.com/lukovkin/hyperopt.git \  
&& pip install git+https://github.com/lukovkin/holidays.py.git \  
&& pip install bdateutil  
  
VOLUME /notebook  
WORKDIR /notebook  
  
# Set up CUDA variables  
ENV CUDA_PATH /usr/local/cuda  
  
ENV OMP_NUM_THREADS=8  
ENV PYTHONPATH=/notebook/nnt-backend-py/:/notebook/UFCNN/ufcnn:  
  
# TensorBoard  
EXPOSE 6006  
# IPython  
EXPOSE 8888  
RUN ["/bin/bash"]  

