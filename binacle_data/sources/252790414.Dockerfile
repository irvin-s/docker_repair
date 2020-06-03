FROM debian:jessie  
  
RUN set -x && \  
USR='usr' && \  
PYVERS='3.5.2' && \  
apt-get update && \  
# This is basically the list from  
# https://github.com/yyuu/pyenv/wiki/Common-build-problems  
apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \  
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \  
libncursesw5-dev xz-utils git sudo && \  
  
# Create non-root user  
useradd -m -s /bin/bash -G sudo,users ${USR} && \  
passwd -d ${USR} && \  
  
# Install pyenv and pyenv-virtualenv  
git clone https://github.com/yyuu/pyenv.git /home/${USR}/.pyenv && \  
git clone https://github.com/yyuu/pyenv-virtualenv.git \  
/home/${USR}/.pyenv/plugins/pyenv-virtualenv && \  
  
# Build python with pyenv  
/home/${USR}/.pyenv/plugins/python-build/bin/python-build \  
-v ${PYVERS} /home/${USR}/.pyenv/versions/${PYVERS} && \  
  
# Create a file of the pyenv init commands  
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> pyenvinit && \  
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> pyenvinit && \  
echo 'eval "$(pyenv init -)"' >> pyenvinit && \  
echo 'eval "$(pyenv virtualenv-init -)"' >> pyenvinit && \  
  
# Configure bash and zsh (in case it is installed later) for pyenv  
cat pyenvinit >> /home/${USR}/.bashrc && \  
cat pyenvinit >> /home/${USR}/.zshenv && \  
rm pyenvinit && \  
  
# Set the user's global version to the python we just built  
echo "$PYVERS" > /home/${USR}/.pyenv/version && \  
  
# Correct the owner and group of all the files root created for the user  
chown -R ${USR} /home/${USR} && \  
chgrp -R ${USR} /home/${USR} && \  
  
# Remove build tools to save a bunch of space  
apt-get autoremove -y build-essential llvm  
  
  
WORKDIR /home/usr  
  
USER usr  
  
ENTRYPOINT ["/bin/bash"]  

