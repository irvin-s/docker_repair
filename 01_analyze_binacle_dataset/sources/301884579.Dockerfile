from ubuntu:16.04

# system level programs
run apt-get -qq update
run apt-get -qq install -y ranger
run apt-get -qq install -y tree
run apt-get -qq install -y cloc
run apt-get -qq install -y git
run apt-get -qq install -y vim

# python
run apt-get -qq install -y ipython3
run apt-get -qq install -y python3-pip

# dependencies
copy ./requirements.txt /srv/requirements.txt
workdir /srv
run pip3 install -r requirements.txt

expose 5000
