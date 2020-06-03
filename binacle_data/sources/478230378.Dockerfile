FROM berlius/caffe-gpu

MAINTAINER berlius <berlius52@yahoo.com>

RUN apt-get update && apt-get install imagemagick -y

COPY install-gpu.sh /root/install.sh
COPY settings-gpu.py /root
RUN chmod +x /root/install.sh

WORKDIR "/root/sharedfolder"
CMD ["/bin/bash"]
