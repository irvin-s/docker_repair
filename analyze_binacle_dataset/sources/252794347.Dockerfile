FROM base/archlinux  
  
ADD etc.tar /  
RUN chown root:root /etc -R \  
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \  
&& locale-gen \  
&& pacman -Syu --noconfirm archlinuxcn-keyring \  
$(pacman -Ql | grep '/usr/share/locale/zh_CN' | cut -d' ' -f1 | uniq) \  
&& rm -rf \  
/usr/share/man/* \  
/var/cache/pacman/pkg/* \  
/etc/pacman.d/mirrorlist.pacnew \  
&& for file in $(ls /usr/share/locale/ \  
| grep -v 'en_US' | grep -v 'zh_CN' | grep -v 'locale.alias') ; do \  
rm -rf "/usr/share/locale/$file" ; done  
ENV LANG=zh_CN.UTF-8  
VOLUME /var/cache/pacman/pkg  

