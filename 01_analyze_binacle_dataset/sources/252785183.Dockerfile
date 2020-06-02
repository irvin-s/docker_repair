FROM archimg/base-devel  
MAINTAINER Cognexa Solutions s.r.o. <docker@cognexa.com>  
  
# install common packages  
RUN pacman --noconfirm --needed -Syu \  
pacman-contrib \  
git \  
base-devel \  
gtkglext \  
hdf5 \  
opencv \  
python \  
vim \  
python-numpy \  
python-pandas \  
python-scipy \  
python-pip \  
&& paccache -rfk0  
  
# setup user `aur`  
RUN useradd -m -s /bin/bash aur \  
&& passwd -d aur \  
&& echo 'aur ALL=(ALL) ALL' > /etc/sudoers.d/aur \  
&& echo 'Defaults env_keep += "EDITOR"' >> /etc/sudoers.d/aur  
  
# install `trizen`  
RUN git clone https://aur.archlinux.org/trizen.git \  
&& chown -R aur:aur /trizen \  
&& cd /trizen \  
&& sudo -u aur makepkg -si --needed --noconfirm \  
&& cd / \  
&& rm -rf /trizen \  
&& paccache -rfk0  
  
ENV EDITOR vim  
  
# set UTF-8 locale  
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && locale-gen  
ENV LANG en_US.UTF-8  
# install GPU related stuff if build argument `tag` is set to `cuda`  
ARG tag="latest"  
RUN if [ "${tag}" = "cuda" ]; then \  
pacman --noconfirm --needed -S \  
cuda \  
cudnn \  
&& paccache -rfk0; \  
fi  
  
# set NVIDIA-Docker specific variables  
ENV NVIDIA_VISIBLE_DEVICES all  
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility  
ENV NVIDIA_REQUIRE_CUDA "cuda>=9.1"  

