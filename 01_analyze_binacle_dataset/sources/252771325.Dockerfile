# This Dockerfile builds an image that can be used to build ArchLinux packages  
FROM base/archlinux:latest  
MAINTAINER Aitor Pazos <mail@aitorpazos.es>  
  
RUN pacman-key --init && \  
pacman -Sy --noconfirm archlinux-keyring && \  
pacman -Syu --noconfirm base-devel git boost pkgbuild-introspection && \  
pacman-db-upgrade && \  
update-ca-trust && \  
pacman -Scc --noconfirm  
COPY sudoers /etc/sudoers  
RUN chown -c root:root /etc/sudoers && \  
chmod -c 0440 /etc/sudoers && \  
mkdir -p /work  
VOLUME /work  
WORKDIR /work  
ENV GIT_NAME Default User  
ENV GIT_EMAIL default@user.com  
ENV USER_UID 1000  
CMD useradd -u ${USER_UID} -d /home/makepkg -m makepkg && \  
chown -R makepkg /work /home/makepkg && \  
pacman -Syu --noconfirm && \  
pacman-db-upgrade && \  
pacman -Scc --noconfirm && \  
su -l makepkg -c "git config --global user.name $GIT_NAME" && \  
su -l makepkg -c "git config --global user.email $GIT_EMAIL" && \  
su -l makepkg -c "cd /work && makepkg --noconfirm -si && mksrcinfo"  

