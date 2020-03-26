FROM droid4control/olinuxino-crosscompiler  
  
MAINTAINER Cougar <cougar@random.ee>  
  
VOLUME [ "/data" ]  
  
WORKDIR /usr/src  
  
ADD config-D4C-20150519-minimal /root/  
ADD config-D4C-20150519-minimal-nfs /root/  
ADD imx23.dtsi.diff /root/  
  
ADD build.sh /root/  
  
CMD /root/build.sh  
  
ENV VERSION=3.18.13  

