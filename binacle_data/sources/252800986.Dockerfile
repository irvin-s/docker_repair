from dpollet/texlive:full  
label description "Full TeXlive with support for installing Pharo & Pillar"  
  
run dpkg --add-architecture i386 && \  
apt update && \  
apt install --yes \--no-install-recommends \  
libx11-6:i386 \  
libgl1-mesa-glx:i386 \  
libfontconfig1:i386 \  
libssl1.0.0:i386  

