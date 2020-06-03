FROM base/archlinux  
MAINTAINER David Parrish  
  
# Full Arch update.  
RUN pacman -Syuq --noconfirm --ignore filesystem  
  
# Get some dependencies for Packer.  
#RUN pacman -Syq --noconfirm --needed git jshon fakeroot binutils  
RUN pacman -Syq --noconfirm --needed base-devel git jshon  
  
# Get Packer to help with installing from AUR  
RUN git clone https://github.com/keenerd/packer.git /opt/packer  
RUN chmod +x /opt/packer/packer  
  
# Install counterparty  
RUN /opt/packer/packer -S --noedit --noconfirm counterpartyd  
  
# Add counterpartyd.sh script entrypoint.  
ADD counterpartyd.sh /usr/local/bin/  
RUN chmod a+x /usr/local/bin/counterpartyd.sh  
ENTRYPOINT ["/usr/local/bin/counterpartyd.sh"]  
  
# Create counterparty user  
RUN useradd -m -s /bin/bash counterparty  
USER counterparty  
RUN mkdir -p /home/counterparty/.local/share/counterpartyd  
ENV HOME /home/counterparty  
VOLUME ["/home/counterparty/.local/share/counterpartyd"]  

