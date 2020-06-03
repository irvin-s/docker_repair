FROM aarch64/ubuntu

#AUTHOR bmwshop@gmail.com
MAINTAINER nuculur@gmail.com
# this is the base container for the Jetson TX2 board with drivers (but without cuda)

# base URL for NVIDIA libs
ARG URL=http://developer.download.nvidia.com/devzone/devcenter/mobile/jetpack_l4t/3.2/pwv346/JetPackL4T_32_b157

#COPY *.sh /tmp/
RUN apt-get update && apt-get install -y bzip2 curl unp sudo
WORKDIR /tmp

# Resultant file: Tegra186_Linux_R28.2.0_aarch64.tbz2
RUN curl -sL http://developer.nvidia.com/embedded/dlc/l4t-jetson-tx2-driver-package-28-2 | tar xvfj -
RUN chown root /etc/passwd /etc/sudoers /usr/lib/sudo/sudoers.so /etc/sudoers.d/README
RUN /tmp/Linux_for_Tegra/apply_binaries.sh -r /
RUN  rm -fr /tmp/* && apt-get clean
