FROM ubuntu:17.04

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/chef/bin:/opt/chef/embedded/bin \
    APT_ARGS="-y --no-install-recommends --no-upgrade" \
    CHEF_REPO_PATH=/tmp/chef
ENV COOKBOOK_PATH=$CHEF_REPO_PATH/cookbooks

# Install chef-client
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install $APT_ARGS \
      ca-certificates \
      curl && \
    curl -L --progress-bar https://www.chef.io/chef/install.sh | bash -s -- -P chefdk

# Configure locales
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install $APT_ARGS \
      locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# Configure Chef Client
RUN mkdir -p $COOKBOOK_PATH && \
    mkdir -p /etc/chef ~/.chef && \
    echo "cookbook_path %w($COOKBOOK_PATH)" > /etc/chef/client.rb && \
    echo "local_mode true" >> /etc/chef/client.rb && \
    echo "chef_zero.enabled true" >> /etc/chef/client.rb && \
    ln /etc/chef/client.rb ~/.chef/config.rb

# Some optional but recommended packages (+33 MB)
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install $APT_ARGS \
    git \
    iproute2

# Clean and remove not required packages
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get autoremove -y && \
    rm -rf /var/cache/apt/archives/*

CMD ["bash"]
