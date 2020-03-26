FROM ubuntu:14.04

# General Installation
RUN apt-get update && apt-get install -y python-pip python-dev git wget libmysqlclient-dev build-essential libssl-dev libffi-dev python-dev rsyslog mysql-client
RUN pip install virtualenv

# Configure Rsyslog and Provision DB
RUN echo 'local0.*    @@docker-kibana:514' > /etc/rsyslog.d/60-neutron.conf
RUN echo "service rsyslog restart" > ~/entrypoint.sh
RUN echo 'mysql -h docker-mysql -u root -e "CREATE DATABASE neutron"'  >> ~/entrypoint.sh

# Update setuptools
RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python

# Make our directories
RUN mkdir /opt/configs /opt/neutron /opt/quark /opt/venv /opt/wafflehaus /opt/wafflehaus.neutron /var/log/neutron
RUN cd /opt/venv && virtualenv . --distribute

# Clone Neutron & Wafflehaus
# NOTE(alexm): enable this after quark is up to date with upstream neutron
# RUN git clone https://github.com/openstack/neutron /opt/neutron
RUN git clone https://github.com/roaet/wafflehaus.git /opt/wafflehaus
RUN git clone https://github.com/roaet/wafflehaus.neutron /opt/wafflehaus.neutron

# NOTE(alexm): enable this when quark is caught up to upstream neutron
# Pull Neutron and Install
# RUN echo "cd /opt/neutron && git pull" >> ~/entrypoint.sh
# RUN echo "source /opt/venv/bin/activate && pip install -U -r /opt/neutron/requirements.txt" >> ~/entrypoint.sh
# RUN echo "cd /opt/neutron && source /opt/venv/bin/activate && python setup.py develop" >> ~/entrypoint.sh

# NOTE(alexm): remove this when quark is caught up to upstream neutron
# Install Neutron
RUN echo "source /opt/venv/bin/activate && pip install -U http://tarballs.openstack.org/neutron/neutron-10.0.1.tar.gz#egg=neutron" >> ~/entrypoint.sh

# Install Quark
RUN echo "source /opt/venv/bin/activate && pip install -U -r /opt/quark/requirements.txt" >> ~/entrypoint.sh
RUN echo "cd /opt/quark && source /opt/venv/bin/activate && python setup.py develop" >> ~/entrypoint.sh

# Install Wafflehaus
RUN echo "cd /opt/wafflehaus && git pull" >> ~/entrypoint.sh
RUN echo "source /opt/venv/bin/activate && pip install -U -r /opt/wafflehaus/requirements.txt" >> ~/entrypoint.sh
RUN echo "cd /opt/wafflehaus && source /opt/venv/bin/activate && python setup.py develop" >> ~/entrypoint.sh

# Install Wafflehaus.Neutron
RUN echo "cd /opt/wafflehaus.neutron && git pull" >> ~/entrypoint.sh
RUN echo "source /opt/venv/bin/activate && pip install -U -r /opt/wafflehaus.neutron/requirements.txt" >> ~/entrypoint.sh
RUN echo "cd /opt/wafflehaus.neutron && source /opt/venv/bin/activate && python setup.py develop" >> ~/entrypoint.sh

# Install debug tools
RUN echo "source /opt/venv/bin/activate && pip install -U ipdb" >> ~/entrypoint.sh

# Put configuration files in place and start Neutron
RUN echo "cp /opt/quark/docker.neutron.conf ~/neutron.conf" >> ~/entrypoint.sh
RUN echo "cp /opt/quark/docker.apipaste.ini ~/api-paste.ini" >> ~/entrypoint.sh
RUN echo "cp /opt/quark/docker.policy.json ~/policy.json" >> ~/entrypoint.sh
# NOTE(alexm): enable this after quark is up to date with upstream neutron
# RUN echo "cp /opt/configs/* ~/" >> ~/entrypoint.sh

RUN echo "source /opt/venv/bin/activate && quark-db-manage --config-file ~/neutron.conf upgrade head"  >> ~/entrypoint.sh
RUN echo "source /opt/venv/bin/activate && neutron-server --config-file ~/neutron.conf"  >> ~/entrypoint.sh

RUN chmod +x ~/entrypoint.sh

EXPOSE 9696

ENTRYPOINT ["/bin/bash", "-c", "~/entrypoint.sh"]
