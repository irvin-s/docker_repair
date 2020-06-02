FROM alpine:3.6  
WORKDIR /usr/local/  
# Waiting on https://pkgs.alpinelinux.org/package/edge/testing/x86/librtlsdr  
# RUN apk add --no-cache rtl-sdr  
RUN apk add --no-cache musl-dev gcc make cmake pkgconf git libusb libusb-dev \  
&& git clone git://git.osmocom.org/rtl-sdr.git \  
&& mkdir /usr/local/rtl-sdr/build \  
&& cd /usr/local/rtl-sdr/build \  
&& cmake ../ -DDETACH_KERNEL_DRIVER=ON -DINSTALL_UDEV_RULES=ON \  
&& make \  
&& make install \  
&& apk del gcc make cmake musl-dev git libusb-dev pkgconf \  
&& cd /usr/local \  
&& rm -rf rtl-sdr  
  
CMD rtl_tcp  
  

