FROM cudnn:latest
MAINTAINER Tammy Yang <tammy@dt42.io>

RUN curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash -e
RUN git clone https://github.com/torch/distro.git ~/torch --recursive
RUN cd ~/torch && ./install.sh

RUN ~/torch/install/bin/luarocks install nn
RUN ~/torch/install/bin/luarocks install dpnn
RUN ~/torch/install/bin/luarocks install image
RUN ~/torch/install/bin/luarocks install optim
RUN ~/torch/install/bin/luarocks install csvigo
RUN ~/torch/install/bin/luarocks install cutorch
RUN ~/torch/install/bin/luarocks install cunn
RUN ~/torch/install/bin/luarocks install cudnn

