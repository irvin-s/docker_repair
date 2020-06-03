FROM ubuntu:16.04  
  
RUN groupadd --gid 1000 ue4 \  
&& useradd --uid 1000 \--gid ue4 --shell /bin/bash --create-home ue4  
  
WORKDIR /opt/ue4  
  
RUN apt-get update && apt-get install -y \  
git \  
tzdata \  
mono-xbuild \  
mono-dmcs \  
libmono-microsoft-build-tasks-v4.0-4.0-cil \  
libmono-system-data-datasetextensions4.0-cil \  
libmono-system-web-extensions4.0-cil \  
libmono-system-management4.0-cil \  
libmono-system-xml-linq4.0-cil \  
libmono-corlib4.5-cil \  
libmono-windowsbase4.0-cil \  
libmono-system-io-compression4.0-cil \  
libmono-system-io-compression-filesystem4.0-cil \  
libmono-system-runtime4.0-cil \  
mono-devel \  
clang-3.8 \  
llvm \  
build-essential \  
&& rm -rf /var/lib/apt/lists/*  
  
USER ue4  
  
CMD ./Setup.sh && \  
./GenerateProjectFiles.sh && \  
make  

