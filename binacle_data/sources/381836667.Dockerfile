FROM ubuntu:18.04

RUN apt-get update \
        && apt-get install -y --no-install-recommends git ansible \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

# not necessary, since snark install.yml also installs comma
# just an example in case you need only comma and do not need snark
RUN mkdir /root/src -p \
        && cd /root/src \
        && git clone https://gitlab.com/orthographic/comma.git \
        && ansible-playbook /root/src/comma/system/ansible/install.yml
        
RUN mkdir /root/src -p \
        && cd /root/src \
        && git clone https://gitlab.com/orthographic/snark.git \
        && /bin/bash -c "ansible-playbook /root/src/snark/system/ansible/install.yml"
