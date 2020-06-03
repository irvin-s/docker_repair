FROM base/archlinux  
  
RUN pacman -Sy --noconfirm  
RUN pacman -S --noconfirm --needed \  
archlinux-keyring \  
&& paccache -r -k 0  
RUN pacman -Su --noconfirm \  
&& paccache -r -k 0  
RUN pacman-db-upgrade  
RUN pacman -S --noconfirm --needed \  
base-devel \  
cmake \  
git \  
openssh \  
python \  
sudo \  
&& paccache -r -k 0  
  
COPY makepkg.conf /etc/makepkg.conf  
  
COPY sudoers /etc/sudoers  
RUN chmod 0660 /etc/sudoers  
  
RUN useradd -d /home/buzzy -m -G wheel buzzy  
  
RUN mkdir /home/buzzy/.ssh \  
&& chown buzzy:buzzy /home/buzzy/.ssh \  
&& chmod 0700 /home/buzzy/.ssh \  
&& ssh-keyscan github.com >> /home/buzzy/.ssh/known_hosts \  
&& chown buzzy:buzzy /home/buzzy/.ssh/known_hosts \  
&& chmod 0600 /home/buzzy/.ssh/known_hosts  
  
USER buzzy  
ENV HOME /home/buzzy  
WORKDIR /home/buzzy  
CMD ["/bin/bash"]  

