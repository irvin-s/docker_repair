FROM nightseas/pyopencl

ENV AMD_DRI_VER=16.40-348864

RUN apt-get install -y dkms libglib2.0-0 libgstreamer-plugins-base1.0-0 libepoxy0 \
libgstreamer1.0-0 libomxil-bellagio0 libcunit1 libx11-xcb1 libxcb-dri2-0 \
libxcb-glx0 libxdamage1 libxfixes3 libxxf86vm1 libxcb-dri3-0 libxcb-present0 \
libxcb-sync1 libxshmfence1 libelf1 libvdpau1 libelf1 libomxil-bellagio0

COPY amdgpu-pro-$AMD_DRI_VER.tar.gz /root

RUN cd /root && tar xzf amdgpu-pro-$AMD_DRI_VER.tar.gz && dpkg -i /root/amdgpu-pro-$AMD_DRI_VER/*.deb && rm -rf /root/amdgpu*

CMD sh -c clinfo

