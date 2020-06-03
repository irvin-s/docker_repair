FROM dsdgroup/jupyter:gpu-cuda-8.0  
  
MAINTAINER Guo Quan <guoquanscu@gmail.com>  
  
ENV REFRESHED_AT 2016-08-10  
  
# Install python-nose  
RUN apt-get update && apt-get install -y python-nose  
  
# Set CUDA_ROOT  
ENV CUDA_ROOT /usr/local/cuda/bin  
  
# Install bleeding-edge Theano  
RUN pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git  
  
# Set up .theanorc for CUDA  
RUN echo "[global]" > /root/.theanorc && \  
echo "device=gpu" >> /root/.theanorc && \  
echo "floatX=float64" >> /root/.theanorc && \  
echo "optimizer_including=cudnn" >> /root/.theanorc && \  
echo "[lib]" >> /root/.theanorc && \  
echo "cnmem=0.1" >> /root/.theanorc && \  
echo "[nvcc]" >> /root/.theanorc && \  
echo "fastmath=True" >> /root/.theanorc  

