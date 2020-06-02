FROM mesosphere/mesosphere-jupyter-service

ARG CONDA_ENV_YML="jupyter-root-conda-cudnn-env.yml"
ARG IBM_GPU_ENABLER_JAR_SHA256="4d5919003fdf915a747f51af83d851bc07588706b415f2a8a24c666bb5a7f977"
ARG IBM_GPU_ENABLER_URL="https://downloads.mesosphere.com/mesosphere-jupyter-service/assets/ibm/gpu-enabler"
ARG IBM_GPU_ENABLER_VERSION="2.0.0"
ARG NVIDIA_CUDA_MAJOR_VERSION="9-0"
ARG NVIDIA_CUDA_PKG_VERSION="9.0.176"
ARG NVIDIA_CUDA_VERSION="9.0"
ARG NVIDIA_CUDA_TOOLS_GPG_KEY="7fa2af80"
ARG NVIDIA_CUDNN_MAJOR_VERSION="7"
ARG NVIDIA_CUDNN_PKG_VERSION="7.4.1.5-1+cuda9.0"
ARG NVIDIA_DISTRO="ubuntu1604"
ARG NVIDIA_DRIVER_CAPABILITIES="compute,utility"
ARG NVIDIA_NCCL_MAJOR_VERSION="2"
ARG NVIDIA_NCCL_PKG_VERSION="2.3.7-1+cuda9.0"
ARG NVIDIA_REQUIRE_CUDA="cuda>=9.0"
ARG NVIDIA_URL="http://developer.download.nvidia.com/compute"
ARG NVIDIA_VISIBLE_DEVICES="all"
ARG NVIDIA_VOLUMES_NEEDED="nvidia_driver"
ARG TENSORFLOW_JNI_SHA256="bfb4c6e7e983643dd496b8be6131062cf9ada515745eff1386ac3bd39ab14cc3"
ARG TENSORFLOW_URL="https://storage.googleapis.com/tensorflow"
ARG TENSORFLOW_VARIANT="gpu"
ARG TENSORFLOW_VERSION="1.11.0"

LABEL com.nvidia.volumes.needed=${NVIDIA_VOLUMES_NEEDED:-"nvidia_driver"} \
      com.nvidia.cuda.version="${NVIDIA_CUDA_PKG_VERSION}" \
      com.nvidia.cudnn.version="${NVIDIA_CUDNN_VERSION}"

USER root

# Need to unset LD_LIBRARY_PATH first so that libraries in ${MESOSPHERE_PREFIX}/libmesos-bundle/lib don't interfere with apt
RUN unset LD_LIBRARY_PATH \
    && apt-key adv --keyserver "${GPG_KEYSERVER}" --recv-keys "${NVIDIA_CUDA_TOOLS_GPG_KEY}" \
    && echo "deb ${NVIDIA_URL}/cuda/repos/${NVIDIA_DISTRO}/x86_64 /" > /etc/apt/sources.list.d/nvidia-cuda.list \
    && echo "deb ${NVIDIA_URL}/machine-learning/repos/${NVIDIA_DISTRO}/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list \
    && apt-get update -yq --fix-missing \
    && apt-get install -yq --no-install-recommends \
       "cuda-cudart-${NVIDIA_CUDA_MAJOR_VERSION}=${NVIDIA_CUDA_PKG_VERSION}-1" \
       "cuda-libraries-${NVIDIA_CUDA_MAJOR_VERSION}=${NVIDIA_CUDA_PKG_VERSION}-1" \
       "cuda-libraries-dev-${NVIDIA_CUDA_MAJOR_VERSION}=${NVIDIA_CUDA_PKG_VERSION}-1" \
       "libnccl${NVIDIA_NCCL_MAJOR_VERSION}=${NVIDIA_NCCL_PKG_VERSION}" \
       "libcudnn${NVIDIA_CUDNN_MAJOR_VERSION}=${NVIDIA_CUDNN_PKG_VERSION}" \
    && apt-mark hold libnccl2 \
    && apt-mark hold libcudnn7 \
    && cd /usr/local \
    && ln -s "cuda-${NVIDIA_CUDA_VERSION}" cuda \
    && cd cuda-"${NVIDIA_CUDA_VERSION}/targets/x86_64-linux/lib" \
    && ln -s stubs/libcuda.so libcuda.so.1 \
    && echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf \
    && echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf \
    && cd /opt/spark/jars \
    && curl --retry 3 -fsSL -O "${IBM_GPU_ENABLER_URL}/${IBM_GPU_ENABLER_VERSION}/gpu-enabler_2.11-${IBM_GPU_ENABLER_VERSION}.jar" \
    && echo "${IBM_GPU_ENABLER_JAR_SHA256}" "gpu-enabler_2.11-${IBM_GPU_ENABLER_VERSION}.jar" | sha256sum -c - \
    && cd /tmp \
    && curl --retry 3 -fsSL -O "${TENSORFLOW_URL}/libtensorflow/libtensorflow_jni-${TENSORFLOW_VARIANT}-linux-x86_64-${TENSORFLOW_VERSION}.tar.gz" \
    && echo "${TENSORFLOW_JNI_SHA256}" "libtensorflow_jni-${TENSORFLOW_VARIANT}-linux-x86_64-${TENSORFLOW_VERSION}.tar.gz" | sha256sum -c - \
    && tar xf "libtensorflow_jni-${TENSORFLOW_VARIANT}-linux-x86_64-${TENSORFLOW_VERSION}.tar.gz" "./libtensorflow_jni.so" \
    && mv "libtensorflow_jni.so" "/usr/lib" \
    && rm "libtensorflow_jni-${TENSORFLOW_VARIANT}-linux-x86_64-${TENSORFLOW_VERSION}.tar.gz" \
    && ldconfig \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --chown="1000:100" "${CONDA_ENV_YML}" "${CONDA_DIR}/"

USER $NB_UID

RUN ${CONDA_DIR}/bin/conda env update --json -q -f "${CONDA_DIR}/${CONDA_ENV_YML}" \
    && ${CONDA_DIR}/bin/conda clean --json -tipsy \
    && ${CONDA_DIR}/bin/npm cache clean --force \
    && rm -rf "${CONDA_DIR}/share/jupyter/lab/staging" \
    && rm -rf "${HOME}/.cache/pip" "${HOME}/.cache/yarn" "${HOME}/.node-gyp" \
    && fix-permissions ${CONDA_DIR} \
    && fix-permissions ${HOME}

ENV NVIDIA_VISIBLE_DEVICES=${NVIDIA_VISIBLE_DEVICES:-"all"} \
    NVIDIA_DRIVER_CAPABILITIES=${NVIDIA_DRIVER_CAPABILITIES:-"compute,utility"} \
    NVIDIA_REQUIRE_CUDA=${NVIDIA_REQUIRE_CUDA:-"cuda>=9.0"} \
    PATH="/usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}" \
    LD_LIBRARY_PATH="/usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}"
