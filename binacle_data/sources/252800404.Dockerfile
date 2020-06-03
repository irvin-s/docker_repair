FROM ubuntu:16.04  
MAINTAINER Chelsea Mafrica <chelsea.e.mafrica@intel.com>  
  
COPY intel-linux-media_generic_16.5.1-59511_64bit.tar.gz /root/  
RUN apt-get update && \  
apt-get install -y expect libpciaccess-dev && \  
apt-get clean all && \  
useradd user && \  
usermod -a -G sudo user && \  
usermod -a -G video user && \  
rm -f /usr/lib/libva* && \  
rm -f /usr/local/lib/libva* && \  
rm -f /usr/lib64/libva* && \  
rm -f /usr/lib64/libdrm* && \  
cd root && \  
tar -xvf intel-linux-media_generic_16.5.1-59511_64bit.tar.gz && \  
cp -dfr usr/* /usr/ && \  
cp -dfr usr/lib64/* /usr/lib/x86_64-linux-gnu/ && \  
MEDIASDK_DIR=opt/intel/mediasdk && \  
mkdir -p /$MEDIASDK_DIR && \  
cp -dfr $MEDIASDK_DIR/* /$MEDIASDK_DIR && \  
MDF_DIR=opt/intel/common/mdf && \  
mkdir -p /$MDF_DIR && \  
cp -dfr $MDF_DIR/* /$MDF_DIR && \  
cp -f etc/profile.d/intel-mediasdk.* /etc/profile.d/ && \  
cp -f etc/profile.d/intel-mediasdk-devel.* /etc/profile.d/ && \  
cp -dfr etc/* /etc/ && \  
ldconfig && \  
FIRMWARE_SRC_PATH=lib/firmware/i915 && \  
mkdir -p /$FIRMWARE_SRC_PATH && \  
cp -dfr $FIRMWARE_SRC_PATH/* /$FIRMWARE_SRC_PATH && \  
rm -rf *  
  
# Use this as daemon, pass volumes to /mnt/share  
COPY transcoder_daemon.sh /usr/local/bin/  
COPY sample_multi_transcode /usr/local/bin/  
  
ENTRYPOINT ["transcoder_daemon.sh"]  
  

