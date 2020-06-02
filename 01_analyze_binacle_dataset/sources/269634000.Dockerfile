ARG COREOS_VERSION=1800.5.0
ARG NVIDIA_DRIVER_VERSION=396.44
ARG NVIDIA_PRODUCT_TYPE=tesla
ARG NVIDIA_SITE=us.download.nvidia.com/tesla

FROM bugroger/coreos-developer:${COREOS_VERSION} as BUILD
LABEL maintainer "Michael Schmidt <michael.j.schmidt@gmail.com>"

ARG COREOS_VERSION
ARG NVIDIA_DRIVER_VERSION
ARG NVIDIA_PRODUCT_TYPE
ARG NVIDIA_SITE
ENV DRIVER_ARCHIVE=NVIDIA-Linux-x86_64-${NVIDIA_DRIVER_VERSION}

# We need to prepare the Container Linux Developer image. As described at 
# https://coreos.com/os/docs/latest/kernel-modules.html we need to get source 
# packages and prepare the linux source tree.
#
# In Docker the `/proc` filesystem does not work as expected, so a bit more magic
# is required. 

RUN emerge-gitclone
RUN . /usr/share/coreos/release && \
  git -C /var/lib/portage/coreos-overlay checkout build-${COREOS_RELEASE_VERSION%%.*}
RUN emerge -gKv coreos-sources > /dev/null
RUN cp /usr/lib64/modules/$(ls /usr/lib64/modules)/build/.config /usr/src/linux/
RUN make -C /usr/src/linux modules_prepare

# Download, extract and move the NVIDIA driver (it won't build in /tmp)

WORKDIR /tmp
RUN echo "curl -v -L http://${NVIDIA_SITE}/${NVIDIA_DRIVER_VERSION}/${DRIVER_ARCHIVE}.run -o ${DRIVER_ARCHIVE}.run"
RUN curl -v -L http://${NVIDIA_SITE}/${NVIDIA_DRIVER_VERSION}/${DRIVER_ARCHIVE}.run -o ${DRIVER_ARCHIVE}.run
RUN chmod +x ${DRIVER_ARCHIVE}.run 
RUN ./${DRIVER_ARCHIVE}.run -x 
RUN mv ${DRIVER_ARCHIVE} /build
RUN mkdir /dest 

# This abomination doesn't come with source and is encrypted into a binary blob. The
# only way to build the driver is to try and install it. -.- 

RUN /build/nvidia-installer -s -n \
  --kernel-source-path=/usr/src/linux \
  --no-check-for-alternate-installs \
  --no-kernel-module-source \
  --no-opengl-files \
  --no-distro-scripts \
  --kernel-install-path=/dest \
  --log-file-name=${PWD}/nvidia-installer.log || true

# Ok, so the installer always fails. It tries to load the built kernel module. That
# doesn't work in the Docker container at this time. We usually don't have a GPU or
# permissions to do so. 
#
# In order to figure out whether the installer actually built the modules, we check
# for the error in the installation log. If it gets that far to actually load the
# module, we assume the build worked.

RUN grep "ERROR: Unable to load the kernel module 'nvidia.ko'" ${PWD}/nvidia-installer.log 

# We copy the created binaries, shared libraries and kernel modules to a clean 
# folder. 

RUN mkdir -p /opt/nvidia/${NVIDIA_DRIVER_VERSION}/${COREOS_VERSION}/bin
RUN mkdir -p /opt/nvidia/${NVIDIA_DRIVER_VERSION}/${COREOS_VERSION}/lib64/modules/$(ls /usr/lib64/modules)/kernel/drivers/video/nvidia
RUN find /build        -maxdepth 1 -name "nvidia-*" -executable -exec cp {} /opt/nvidia/${NVIDIA_DRIVER_VERSION}/${COREOS_VERSION}/bin \; 
RUN find /build        -maxdepth 1 -name "*.so.*"               -exec cp {} /opt/nvidia/${NVIDIA_DRIVER_VERSION}/${COREOS_VERSION}/lib64 \; 
RUN find /build/kernel -maxdepth 1 -name "*.ko"                 -exec cp {} /opt/nvidia/${NVIDIA_DRIVER_VERSION}/${COREOS_VERSION}/lib64/modules/$(ls /usr/lib64/modules)/kernel/drivers/video/nvidia \; 


# Create a clean transport image containing only the driver

FROM ubuntu 
LABEL maintainer "Michael Schmidt <michael.j.schmidt@gmail.com>"

ARG COREOS_VERSION
ARG NVIDIA_DRIVER_VERSION
ARG NVIDIA_PRODUCT_TYPE

ENV NVIDIA_DRIVER_COREOS_VERSION $COREOS_VERSION
ENV NVIDIA_DRIVER_VERSION $NVIDIA_DRIVER_VERSION
ENV NVIDIA_PRODUCT_TYPE $NVIDIA_PRODUCT_TYPE

RUN apt-get update -qq && \
    apt-get install -y kmod && \
    rm -rf /var/lib/apt/lists/*

COPY --from=BUILD /opt/nvidia /opt/nvidia
COPY install.sh /

ENTRYPOINT ["/install.sh"]
