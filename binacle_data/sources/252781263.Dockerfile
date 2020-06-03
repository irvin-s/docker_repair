FROM yantis/ssh-hpn-x  
MAINTAINER Jonathan Yantis <yantis@yantis.net>  
  
RUN pacman -Syy && \  
pacman -S --noconfirm archlinux-keyring && \  
pacman -S --noconfirm lzo libcap-ng && \  
pacman -Su --noconfirm --force && \  
pacman --noconfirm -S thunderbird \  
libcanberra \  
\--assume-installed hwids \  
\--assume-installed kbd \  
\--assume-installed kmod \  
\--assume-installed libseccomp \  
\--assume-installed systemd && \  
rm -r /usr/share/man/* && \  
rm -r /usr/share/doc/* && \  
bash -c "echo 'y' | pacman -Scc >/dev/null 2>&1" && \  
paccache -rk0 >/dev/null 2>&1 && \  
pacman-optimize && \  
rm -r /var/lib/pacman/sync/*  
  
CMD ["/init"]  
  

