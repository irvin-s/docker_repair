FROM fedora:26

RUN dnf update -y && dnf install -y pulp-rpm-plugins pulp-docker-plugins \
    pulp-ostree-plugins pulp-puppet-plugins pulp-python-plugins \
    python-qpid python-qpid-qmf qpid-tools python-gofer-qpid && dnf clean all

EXPOSE 80

# delete default and link to where the secret gets mounted
RUN rm /etc/pulp/server.conf
RUN ln -s /var/run/secrets/pulp/pulp-config/server.conf /etc/pulp/server.conf

# delete original and link to where the secret gets mounted
RUN rm /etc/pki/pulp/rsa*
RUN ln -s /var/run/secrets/pulp/pulp-config/rsa.key /etc/pki/pulp/rsa.key
RUN ln -s /var/run/secrets/pulp/pulp-config/rsa_pub.key /etc/pki/pulp/rsa_pub.key

# This script should be run once per deployment before anything else.
ADD setup.sh /setup.sh

ADD run-apache.sh /run-apache.sh
RUN chmod -v +x /run-apache.sh

CMD ["/run-apache.sh"]
