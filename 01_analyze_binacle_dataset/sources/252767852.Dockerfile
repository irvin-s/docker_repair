FROM acrom18/manjaro-base-build  
  
RUN /usr/bin/useradd -m builder && \  
echo 'builder ALL=(root) NOPASSWD:/usr/bin/pacman' > /etc/sudoers.d/makepkg  
  
RUN sed -i '44cMAKEFLAGS="-j$(($(nproc) + 1))"' /etc/makepkg.conf && \  
sed -i '114cPKGDEST=/build/packages' /etc/makepkg.conf && \  
sed -i '116cSRCDEST=/build/sources' /etc/makepkg.conf && \  
sed -i '118cSRCPKGDEST=/build/srcpackages' /etc/makepkg.conf && \  
sed -i '120cLOGDEST=/build/makepkglogs' /etc/makepkg.conf && \  
sed -i '132cCOMPRESSXZ=(xz -c -z -T0 -)' /etc/makepkg.conf  
  
# delete and create package cache directory for volume mounting  
RUN rm -fr /var/cache/pacman/pkg  
RUN ln -s /pkgcache /var/cache/pacman/pkg  
  
# RUN sed -i "/\\[core\\]/ { N; s|\\[core\\]\n|\  
# \\[packages\\]\n\  
# SigLevel = Optional TrustAll\n\  
# Server = file:///build/packages\n\n&| } " /etc/pacman.conf  
RUN rm /usr/sbin/pinentry && \  
ln -s /usr/sbin/pinentry-curses /usr/sbin/pinentry  
  
ADD makepackage.sh /makepackage.sh  
RUN chmod a+rx /makepackage.sh  
  
VOLUME [ '/build' '/gpg' '/pkgcache' ]  
  
CMD [ "/makepackage.sh" ]  

