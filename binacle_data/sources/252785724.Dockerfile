# Builds a Docker image with Ubuntu 16.04, gcc, python3 and Atom  
#  
# Authors:  
# Xiangmin Jiao <xmjiao@gmail.com>  
  
FROM x11vnc/desktop:latest  
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"  
  
USER root  
WORKDIR /tmp  
  
ADD image/home $DOCKER_HOME/  
# Install system packages  
RUN add-apt-repository ppa:webupd8team/atom && \  
apt-get update && \  
apt-get install -y --no-install-recommends \  
build-essential \  
gfortran \  
cmake \  
bison \  
flex \  
git \  
bash-completion \  
bsdtar \  
rsync \  
wget \  
ccache \  
\  
meld \  
atom \  
clang-format && \  
apt-get install -y --no-install-recommends \  
python3-pip \  
python3-dev \  
pandoc \  
ttf-dejavu && \  
apt-get clean && \  
pip3 install -U \  
setuptools && \  
pip3 install -U \  
autopep8 \  
flake8 && \  
echo "move_to_config atom" >> /usr/local/bin/init_vnc && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
########################################################  
# Customization for user  
########################################################  
RUN apm install \  
language-cpp14 \  
language-matlab \  
language-r \  
language-fortran \  
language-docker \  
autocomplete-python \  
autocomplete-fortran \  
git-plus \  
merge-conflicts \  
split-diff \  
gcc-make-run \  
platformio-ide-terminal \  
intentions \  
busy-signal \  
linter-ui-default \  
linter \  
linter-gcc \  
linter-gfortran \  
linter-flake8 \  
dbg \  
output-panel \  
dbg-gdb \  
python-debugger \  
auto-detect-indentation \  
python-autopep8 \  
clang-format && \  
rm -rf /tmp/* && \  
echo '@atom .' >> $DOCKER_HOME/.config/lxsession/LXDE/autostart && \  
chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME  
  
WORKDIR $DOCKER_HOME  

