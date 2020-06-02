FROM berlius/caffe-cpu

MAINTAINER berlius <berlius52@yahoo.com>

RUN apt-get update && apt-get install imagemagick -y

COPY install-cpu.sh /root/install.sh
COPY settings-cpu.py /root
RUN chmod +x /root/install.sh

WORKDIR "/root/sharedfolder"
CMD ["/bin/bash"]
