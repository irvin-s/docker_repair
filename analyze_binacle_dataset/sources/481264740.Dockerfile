FROM ubuntu:trusty
RUN apt-get update && \
      apt-get install -y wget lsb-core libglib2.0 clinfo opencl-headers git curl libgl1-mesa-dev && \
      rm -r /var/lib/apt/lists/* && \
      wget -O o.tgz http://registrationcenter-download.intel.com/akdlm/irc_nas/9019/opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25.tgz && \
      tar -xvzf o.tgz && rm o.tgz && \
      cd opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25/ && \
      sed -i -e "s/ACCEPT_EULA=decline/ACCEPT_EULA=accept/" silent.cfg && \
      ./install.sh -s silent.cfg < /dev/null && \
      clinfo && \
      cd .. && \
      rm -r opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25 # TODO: apt-get remove wget git curl clinfo

CMD clinfo
