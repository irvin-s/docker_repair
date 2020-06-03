FROM debian:7

RUN apt-get update

RUN apt-get install -y python2.7

RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 10

RUN apt-get install -y python-pip python-dev libmysqlclient-dev rpm bzip2 wget git build-essential libssl-dev libffi-dev

RUN pip install --upgrade cffi pyasn1

RUN pip install virtualenv PyYAML jinja2 paramiko

RUN git clone https://github.com/ansible/ansible.git

RUN cd ansible

RUN cd ansible && git checkout tags/v1.9.1-1

RUN cd ansible && git submodule update --init --recursive

RUN cd ansible && make install

RUN mkdir /etc/ansible

RUN cd ansible && cp examples/ansible.cfg /etc/ansible/.

RUN mkdir -p /root/ansible /root/.ssh

ENTRYPOINT ["/bin/bash", "-c", "cd /root/ansible && ansible-playbook -i localhost, /root/ansible/package-neutron.yaml"]