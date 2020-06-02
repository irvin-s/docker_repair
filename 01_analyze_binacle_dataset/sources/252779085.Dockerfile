FROM base/archlinux  
  
MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)  
  
  
# 不清楚為何 Docker Hub 沒有 rankmirrors 命令，故此命令請自行檢查  
# 如果沒有使用預設站點，在本地執行 `pacman -Syu` 會有以下訊息  
# error: failed to update extra (no servers configured for repository)  
# 鏡像站點： 臺灣  
RUN if type rankmirrors &> /dev/null; then \  
echo -e '\  
Server = http://ftp.tku.edu.tw/Linux/ArchLinux/$repo/os/$arch\n\  
Server = https://shadow.ind.ntou.edu.tw/archlinux/$repo/os/$arch\n\  
Server = http://archlinux.cs.nctu.edu.tw/$repo/os/$arch\n\  
Server = https://ftp.yzu.edu.tw/Linux/archlinux/$repo/os/$arch\  
' | rankmirrors -n 3 - >> /etc/pacman.d/mirrorlist; \  
cat /etc/pacman.d/mirrorlist; \  
else \  
echo '使用預設的鏡像站。'; \  
fi  
  
# RUN pacman -Rs arch-install-scripts  
RUN pacman -Syu --noconfirm  
  
## 時間跟隨主機  
RUN ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime  
  
RUN sed -i "s/^#\\(\\(en_US\|zh_TW\\).UTF-8 UTF-8\\)/\1/" /etc/locale.gen; \  
locale-gen  
ENV LANG zh_TW.UTF-8  
ENV LC_TIME en_US.UTF-8  
# ENV LC_ALL zh_TW.UTF-8  
RUN pacman -S --noconfirm \  
systemd \  
iproute2  
  
RUN pacman -S --noconfirm \  
bash-completion vim \  
sudo openssh \  
git tmux tree wget \  
python  
# openssh 為 git 與遠程端通訊的工具  
# python 為 vim 程式包的依賴  
RUN ln -s /usr/bin/vim /usr/bin/vi  
  
RUN pacman -S --noconfirm \  
cifs-utils ntfs-3g exfat-utils \  
unzip  
  

