FROM gcr.io/tensorflow/tensorflow

MAINTAINER berlius <berlius52@yahoo.com>

RUN apt-get update && apt-get install -y \
    git \
    python-tk
    
RUN pip install sugartensor tqdm

COPY install.sh /root/install.sh
RUN chmod +x /root/install.sh

WORKDIR "/root/sharedfolder"
CMD ["/bin/bash"]
