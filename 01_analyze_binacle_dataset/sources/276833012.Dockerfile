FROM arm64v8/ubuntu:16.04
LABEL maintainer "Drew Farris <drew.farris@gmail.com>"

ENV CUDA_VERSION 8.0.64
LABEL com.nvidia.cuda.version="${CUDA_VERSION}"
ENV NVIDIA_CUDA_VERSION $CUDA_VERSION

ENV CUDA_PKG_VERSION 8-0=$CUDA_VERSION-1

RUN apt-get update && apt-get -y install wget

ADD fixrepos.sh /tmp/
RUN chmod +x /tmp/fixrepos.sh && /tmp/fixrepos.sh

RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-nvrtc-$CUDA_PKG_VERSION \
    cuda-nvgraph-$CUDA_PKG_VERSION \
    cuda-cusolver-$CUDA_PKG_VERSION \
    cuda-cublas-$CUDA_PKG_VERSION \
    cuda-cufft-$CUDA_PKG_VERSION \
    cuda-curand-$CUDA_PKG_VERSION \
    cuda-cusparse-$CUDA_PKG_VERSION \
    cuda-npp-$CUDA_PKG_VERSION \
    cuda-cudart-$CUDA_PKG_VERSION && \
  ln -s cuda-8.0 /usr/local/cuda && \
  rm -rf /var/lib/apt/lists/*

RUN echo "/usr/local/cuda/lib64" >> /etc/ld.so.conf.d/cuda.conf && \
    ldconfig

# nvidia-docker 1.0
LABEL com.nvidia.volumes.needed="nvidia_driver"

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/lib/aarch64-linux-gnu/tegra:/usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN mkdir /cudaSamples
COPY deviceQuery /cudaSamples/
ADD deviceQuery /
