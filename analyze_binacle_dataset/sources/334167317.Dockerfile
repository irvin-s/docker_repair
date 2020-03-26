
FROM openshift/base-centos7

# We will install a newer version of git. Remove the old one.
RUN yum erase -y git

# Install both python2 and 3 and other required tools.
# The tools are mostly for tests, documentation generation to run.
RUN yum install -y epel-release \
    && yum-config-manager  --add-repo https://copr.fedorainfracloud.org/coprs/randomvariable/jsonnet/repo/epel-7/randomvariable-jsonnet-epel-7.repo \
    && yum install -y jsonnet \
    && yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
    && yum install -y python-pip python36u python36u-pip jq git2u \
    && wget https://github.com/jgm/pandoc/releases/download/2.2.1/pandoc-2.2.1-linux.tar.gz \
    && tar xvzf pandoc-2.2.1-linux.tar.gz  --strip-components 1 -C /usr/local/


# Turn off ssh host key checking. Avoid yes/no prompts for user input while circle
# ci is reaching out to github
RUN echo $'Host * \n\
   StrictHostKeyChecking no \n\
   UserKnownHostsFile=/dev/null' >> /etc/ssh/ssh_config

