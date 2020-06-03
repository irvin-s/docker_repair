FROM alpine:3.7  
# Install base packages and build dependencies  
RUN set -ex; \  
apk add --no-cache \  
bash \  
libzmq \  
python3 \  
py-setuptools; \  
apk add --no-cache --virtual command-line-tools \  
busybox-extras \  
curl \  
jq \  
wget; \  
apk add --no-cache --virtual build-dependencies \  
g++ \  
gcc \  
git \  
libffi-dev \  
musl-dev \  
openssl-dev \  
python3-dev;  
  
# Install BATS in /usr/local  
RUN set -ex; \  
git clone https://github.com/sstephenson/bats.git; \  
cd bats; \  
./install.sh /usr/local; \  
cd ../; \  
rm -rf bats;  
  
# Install Python modules through pipenv  
COPY Pipfile Pipfile  
COPY Pipfile.lock Pipfile.lock  
RUN set -ex; \  
pip3 install --no-cache-dir pipenv; \  
pipenv --python 3 install --system --verbose;\  
pip3 uninstall --yes pipenv; \  
rm -f Pipfile Pipfile.lock;  
  
# Clean up unnecessary packages  
RUN apk del build-dependencies;  
  
# Prevent python from creating .pyc files and __pycache__ dirs  
ENV PYTHONDONTWRITEBYTECODE=1  
# Show stdout when running in docker compose (dont buffer)  
ENV PYTHONUNBUFFERED=1  
# Add a python startup file  
COPY pystartup /usr/local/share/python/pystartup  
ENV PYTHONSTARTUP=/usr/local/share/python/pystartup  
  
# Add an entry point script.  
COPY entry.sh /usr/local/bin/entry.sh  
RUN set -ex; \  
chmod 755 /usr/local/bin/entry.sh;  

