
from ubuntu:14.04
maintainer atupal me@atupal.org

# add aliyun mirror
run perl -p -i.orig -e 's/archive.ubuntu.com/mirrors.aliyun.com\/ubuntu/' /etc/apt/sources.list
run apt-get update
run apt-get install -y build-essential git

run apt-get install -y redis-server
run apt-get install -y python python-dev python-setuptools
run easy_install pip

run apt-get install -y libxml2-dev libxslt1-dev

# fix /usr/bin/ld: cannot find -lz
run apt-get install -y zlib1g-dev

# numpy dependency
run apt-get install -y libblas-dev 
run apt-get install -y libatlas-dev liblapack-dev

# run pip install
add ./requirements.txt /home/docker/code/requirements.txt
add . /home/docker/code
run pip install -r /home/docker/code/requirements.txt -i http://pypi.douban.com/simple

WORKDIR /home/docker/code
cmd ["celery", "-A", "celeryapp", "worker", "-c", "500", "-P", "gevent", "--soft-time-limit", "10"]
