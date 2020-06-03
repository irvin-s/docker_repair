FROM continuumio/miniconda3  
MAINTAINER aseishas@stanford.edu  
  
# Install dependencies for IRAF  
ENV DEBIAN_FRONTEND noninteractive  
RUN dpkg --add-architecture i386  
RUN apt-get update && apt-get install -y \  
tcsh \  
libc6:i386 \  
libz1:i386 \  
libncurses5:i386 \  
libbz2-1.0:i386 \  
libuuid1:i386 \  
libxcb1:i386 \  
libxmu6:i386  
  
# Install scif  
RUN pip install --upgrade pip  
RUN pip install scif  
  
# Install Astroconda and IRAF  
ADD astroconda.scif /astroconda.scif  
RUN ln -s /opt/conda/bin/python /usr/bin/python  
RUN /opt/conda/bin/conda update -n base conda  
RUN /opt/conda/bin/conda config --add channels http://ssb.stsci.edu/astroconda  
RUN /opt/conda/bin/scif install /astroconda.scif  
RUN ln -s /scif/apps/iraf27/iraf/include/iraf.h /usr/include/iraf.h  
  
ENTRYPOINT ["scif"]  

