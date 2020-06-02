# Start with the ubuntu image
FROM ubuntu:16.04

CMD ["bash"]

# Update apt cache
RUN apt-get -y update

# Install ansible dependencies
RUN apt-get install -y python-dev git aptitude sudo wget make zlib1g-dev libssl-dev build-essential libreadline-dev libyaml-dev libxml2-dev libcurl4-openssl-dev python-software-properties libffi-dev curl

# Install Ruby
WORKDIR /tmp
RUN wget http://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.0.tar.gz
RUN tar -xvzf ruby-2.4.0.tar.gz
WORKDIR /tmp/ruby-2.4.0
RUN ./configure --prefix=/usr/local
RUN make
RUN make install

# Add an authorized_keys file to the container since tape expects this
RUN mkdir -p /root/.ssh
RUN touch /root/.ssh/authorized_keys
RUN chown root:root /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# Clone ansible repo (could also add the ansible PPA and do an apt-get install instead)
RUN apt-get install wget
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install ansible

# Set variables for ansible
WORKDIR /tmp/ansible
ENV PATH /tmp/ansible/bin:/usr/sbin:/sbin:/usr/bin:/bin:$PATH
ENV ANSIBLE_LIBRARY /tmp/ansible/library
ENV PYTHONPATH /tmp/ansible/lib:$PYTHON_PATH

