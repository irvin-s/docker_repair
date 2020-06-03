FROM nightseas/pyopencl

ENV NV_DRI_VER=367
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y nvidia-$NV_DRI_VER nvidia-$NV_DRI_VER-dev nvidia-opencl-icd-$NV_DRI_VER clinfo

CMD sh -c clinfo

