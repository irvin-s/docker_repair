FROM base/archlinux  
  
RUN pacman -Syu --noconfirm \  
dosfstools \  
git \  
lynx \  
make \  
squashfs-tools \  
time \  
xorriso \  
&& pacman -Scc  
  
RUN git clone \--depth 1 https://github.com/atkinchris/archiso.git && \  
cd archiso && \  
make install && \  
cd .. && \  
rm -rf archiso && \  
mkdir /var/livecd && \  
cp -r /usr/share/archiso/configs/releng/* /var/livecd && \  
chmod +x /var/livecd/build.sh  
  
COPY config /var/livecd  
  
WORKDIR /var/livecd  
  
VOLUME ["/var/cache/pacman/", "/tmp/out"]  
  
ENTRYPOINT ["time", "./build.sh", "-o", "/tmp/out"]  
CMD ["-v"]  

