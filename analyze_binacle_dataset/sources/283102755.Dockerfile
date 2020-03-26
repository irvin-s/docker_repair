# Start with cuDNN base image
FROM sayreblades/dask-ecs:cuda8.0-cudnn5-base

# Install git, wget, python-dev, pip, BLAS + LAPACK and other dependencies
RUN apt-get update && apt-get install -y \
  gfortran \
  git \
  wget \
  liblapack-dev \
  libopenblas-dev \
  python3-dev \
  python3-pip

RUN ln -s /usr/bin/python3 /usr/local/bin/python
RUN pip3 --no-cache-dir install --upgrade pip

# Set CUDA_ROOT
ENV CUDA_ROOT /usr/local/cuda/bin

# Install bleeding-edge Theano
RUN pip install --upgrade git+git://github.com/Theano/Theano.git@rel-0.8.2
RUN pip install --upgrade six

# Set up .theanorc for CUDA
RUN printf "[global]\ndevice=gpu\nfloatX=float32\noptimizer_including=cudnn\n[lib]\ncnmem=0.1\n[nvcc]\nfastmath=True" > /root/.theanorc
