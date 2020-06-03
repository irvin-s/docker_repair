FROM fedora:26
MAINTAINER Xabier de Zuazo "xabier@zuazo.org"

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/chef/bin:/opt/chef/embedded/bin \
    LANG=en_US.UTF-8 \
    CHEF_REPO_PATH=/tmp/chef
ENV COOKBOOK_PATH=$CHEF_REPO_PATH/cookbooks

# Install chef-client
RUN curl -L --progress-bar https://www.chef.io/chef/install.sh | bash -s -- -P chefdk

# Configure Chef Client
RUN mkdir -p $COOKBOOK_PATH && \
    mkdir -p /etc/chef ~/.chef && \
    echo "cookbook_path %w($COOKBOOK_PATH)" > /etc/chef/client.rb && \
    echo "local_mode true" >> /etc/chef/client.rb && \
    echo "chef_zero.enabled true" >> /etc/chef/client.rb && \
    ln /etc/chef/client.rb ~/.chef/config.rb

# Some optional but recommended packages
RUN yum install -y \
      git \
      hostname && \
    yum clean all

CMD ["bash"]
