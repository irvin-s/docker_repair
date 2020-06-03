FROM ubuntu:16.04
USER root
ARG DEBIAN_FRONTEND=noninteractive

#--- Packages list
ENV START_SCRIPT="/usr/local/bin/supervisord.sh" \
    INIT_PACKAGES="apt-utils ca-certificates sudo wget curl unzip openssh-server openssl apt-transport-https" \
    TOOLS_PACKAGES="supervisor git-core s3cmd bash-completion apg vim less mlocate nano screen tmux byobu silversearcher-ag colordiff" \
    NET_PACKAGES="netbase net-tools iproute2 iputils-ping dnsutils ldap-utils netcat tcpdump mtr-tiny" \
    DEV_PACKAGES="nodejs python-pip python-dev build-essential libffi-dev libssl-dev libxml2-dev libxslt1-dev libpq-dev libsqlite3-dev libmysqlclient-dev zlib1g-dev libcurl4-openssl-dev" \
    RUBY_PACKAGES="autoconf automake bison libgdbm-dev libncurses5-dev libtool libyaml-dev pkg-config sqlite3 libgmp-dev libreadline6-dev" \
    BDD_PACKAGES="libprotobuf9v5 mongodb-clients" \
    CF_PLUGINS="CLI-Recorder,doctor,manifest-generator,Statistics,Targets,Usage Report"

#--- Packages versions
ENV BBR_VERSION="1.5.0" \
    BOSH_CLI_VERSION="5.4.0" \
    BOSH_CLI_COMPLETION_VERSION="1.1.0" \
    BOSH_GEN_VERSION="0.101.1" \
    BUNDLER_VERSION="1.17.3" \
    CF_CLI_VERSION="6.44.1" \
    CF_UAAC_VERSION="4.1.0" \
    CREDHUB_VERSION="2.2.1" \
    DB_DUMPER_VERSION="1.4.2" \
    FLY_VERSION="3.14.1" \
    HELM_VERSION="2.14.0" \
    JQ_VERSION="1.6" \
    KUBECTL_VERSION="1.14.1" \
    MYSQL_SHELL_VERSION="8.0.16-1" \
    PERIPLI_VERSION="1.0.0" \
    RUBY_VERSION="2.5.1" \
    SHIELD_VERSION="0.10.9" \
    SPRUCE_VERSION="1.20.0" \
    S3GOFR_VERSION="0.5.0" \
    TERRAFORM_PLUGIN_CF_VERSION="0.11.2" \
    TERRAFORM_VERSION="0.11.7"

ADD bosh-cli/*.sh /usr/local/bin/
ADD bosh-cli/profile /tmp/profile
ADD bosh-cli/sshd.conf /etc/supervisor/conf.d/

RUN printf '\n=====================================================\n=> Install system packages\n=====================================================\n' && \
    apt-get update && apt-get install -y --no-install-recommends ${INIT_PACKAGES} ${TOOLS_PACKAGES} ${NET_PACKAGES} ${DEV_PACKAGES} ${RUBY_PACKAGES} ${BDD_PACKAGES} && apt-get upgrade -y && \
    printf '=====================================================\n=> Install Install NodeJS and yarn\n=====================================================\n' && \
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y --no-install-recommends yarn && apt-get upgrade -y && \
    apt-get autoremove -y && apt-get clean && apt-get purge && rm -fr /var/lib/apt/lists/* && \
    printf '\n=====================================================\n=> Install Ruby tools\n=====================================================\n' && \
    curl -sSL https://rvm.io/mpapis.asc | gpg --import - && \
    curl -sSL https://rvm.io/pkuczynski.asc | gpg --import - && \
    curl -sSL https://get.rvm.io | bash -s stable && \
    /bin/bash -l -c "rvm mount -r https://rvm_io.global.ssl.fastly.net/binaries/ubuntu/16.04/x86_64/ruby-${RUBY_VERSION}.tar.bz2 ; rvm install ${RUBY_VERSION} ; rvm use ${RUBY_VERSION}" && \
    /bin/bash -l -c "gem install bundler -v ${BUNDLER_VERSION} --no-ri --no-rdoc" && \
    /bin/bash -l -c "gem install bosh-gen -v ${BOSH_GEN_VERSION} --no-ri --no-rdoc" && \
    /bin/bash -l -c "gem install cf-uaac -v ${CF_UAAC_VERSION} --no-ri --no-rdoc" && \
    /bin/bash -l -c "rvm cleanup all" && \
    printf '\n=====================================================\n=> Setup bosh account, ssh and supervisor\n=====================================================\n' && \
    echo "root:$(date +%s | sha256sum | base64 | head -c 32 ; echo)" | chpasswd && \
    useradd -m -g users -G sudo,rvm -s /bin/bash bosh && echo "bosh ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/bosh && \
    echo "bosh:$(date +%s | sha256sum | base64 | head -c 32 ; echo)" | chpasswd && \
    mkdir -p /var/run/sshd /var/log/supervisor /data/shared && \
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd && \
    sed -i 's/^PermitRootLogin .*/PermitRootLogin no/g' /etc/ssh/sshd_config && \
    sed -i 's/^ChallengeResponseAuthentication .*/ChallengeResponseAuthentication no/g' /etc/ssh/sshd_config && \
    sed -i 's/^PubkeyAuthentication .*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config && \
    sed -i 's/^.*PasswordAuthentication yes.*/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
    sed -i 's/.*\[supervisord\].*/&\nnodaemon=true\nloglevel=debug/' /etc/supervisor/supervisord.conf && \
    printf '\n=====================================================\n=> Install ops tools\n=====================================================\n' && \
    python -m pip install --upgrade pip && python -m pip install --upgrade setuptools && \
    python -m pip install python-openstackclient python-keystoneclient python-novaclient python-neutronclient python-cinderclient python-glanceclient python-swiftclient && \
    wget "https://github.com/geofffranks/spruce/releases/download/v${SPRUCE_VERSION}/spruce-linux-amd64" -nv -O /usr/local/bin/spruce && \
    wget "https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64" -nv -O /usr/local/bin/jq && \
    wget "https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSH_CLI_VERSION}-linux-amd64" -nv -O /usr/local/bin/bosh && \
    wget "https://github.com/thomasmmitchell/bosh-complete/releases/download/v${BOSH_CLI_COMPLETION_VERSION}/bosh-complete-linux" -nv -O /home/bosh/bosh-complete-linux && chmod 755 /home/bosh/bosh-complete-linux && \
    wget "https://cli.run.pivotal.io/stable?release=debian64&version=${CF_CLI_VERSION}&source=github-rel" -nv -O /tmp/cf.deb && dpkg -i /tmp/cf.deb && \
    wget "https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/${CREDHUB_VERSION}/credhub-linux-${CREDHUB_VERSION}.tgz" -nv -O - | tar -xz -C /usr/local/bin && \
    wget "https://github.com/concourse/concourse/releases/download/v${FLY_VERSION}/fly_linux_amd64" -nv -O /usr/local/bin/fly && \
    wget "https://github.com/starkandwayne/shield/releases/download/v${SHIELD_VERSION}/shield-linux-amd64" -nv -O /usr/local/bin/shield && \
    wget "https://github.com/Peripli/service-manager-cli/releases/download/v${PERIPLI_VERSION}/smctl_linux_x86-64" -nv -O /usr/local/bin/smctl && \
    wget "https://github.com/cloudfoundry-incubator/bosh-backup-and-restore/releases/download/v${BBR_VERSION}/bbr-${BBR_VERSION}.tar" -nv -O - | tar -x -C /tmp releases/bbr && mv /tmp/releases/bbr /usr/local/bin/bbr && \
    wget "https://dl.minio.io/client/mc/release/linux-amd64/mc" -nv -O /usr/local/bin/mc && \
    wget "https://github.com/rlmcpherson/s3gof3r/releases/download/v${S3GOFR_VERSION}/gof3r_${S3GOFR_VERSION}_linux_amd64.tar.gz" -nv -O - | tar -xz -C /tmp && mv /tmp/gof3r_${S3GOFR_VERSION}_linux_amd64/gof3r /usr/local/bin/go3fr && \
    wget "https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -nv -O /usr/local/bin/kubectl && chmod 775 /usr/local/bin/kubectl && \
    /usr/local/bin/kubectl completion bash > /etc/bash_completion.d/kubectl && \
    wget "https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz" -nv -O - | tar -xz -C /tmp linux-amd64/helm && mv /tmp/linux-amd64/helm /usr/local/bin/helm && chmod 775 /usr/local/bin/helm && \
    /usr/local/bin/helm completion bash > /etc/bash_completion.d/kubectl && \
    wget "https://dev.mysql.com/get/Downloads/MySQL-Shell/mysql-shell_${MYSQL_SHELL_VERSION}ubuntu16.04_amd64.deb" -nv -O /tmp/mysql-shell.deb && dpkg -i /tmp/mysql-shell.deb && \
    wget "https://raw.githubusercontent.com/rupa/z/master/z.sh" -nv -O /usr/local/bin/z.sh && \
    wget "https://github.com/Orange-OpenSource/db-dumper-cli-plugin/releases/download/v${DB_DUMPER_VERSION}/db-dumper_linux_amd64" -nv -O /tmp/db-dumper-plugin && chmod 755 /tmp/db-dumper-plugin && \
    wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -nv -O /tmp/terraform.zip && unzip -q /tmp/terraform.zip -d /usr/local/bin && \
    export PROVIDER_CLOUDFOUNDRY_VERSION="v${TERRAFORM_PLUGIN_CF_VERSION}" && /bin/bash -c "$(wget https://raw.github.com/orange-cloudfoundry/terraform-provider-cloudfoundry/master/bin/install.sh -O -)" && \
    git clone --depth 1 https://github.com/junegunn/fzf.git /home/bosh/.fzf && chown -R bosh:users /home/bosh/.fzf && su -l bosh -s /bin/bash -c "/home/bosh/.fzf/install --all" && \
    printf '=====================================================\n=> Install CF plugins\n=====================================================\n' && \
    su -l bosh -s /bin/bash -c "export IFS=, ; for plug in \$(echo ${CF_PLUGINS}) ; do cf install-plugin \"\${plug}\" -r CF-Community -f ; done" && \
    su -l bosh -s /bin/bash -c "cf install-plugin /tmp/db-dumper-plugin -f" && rm -f /tmp/db-dumper-plugin && \
    printf '\n=====================================================\n=> Setup system banner\n=====================================================\n' && \
    GIT_VERSION=$(git --version | awk '{print $3}') && \
    APG_VERSION=$(apg -v 2>&1 | grep 'version ' | awk '{print $2}') && \
    MINIO_VERSION=$(mc --version 2>&1 | awk '{print $3}') && \
    MONGO_SHELL_VERSION=$(mongo --version 2>&1 | awk '{print $4}') && \
    printf '\nYour are logged into an ubuntu docker container, which provides several tools :\n' > /etc/motd && \
    printf 'Generic tools:\n' >> /etc/motd && \
    printf "  * apg (${APG_VERSION}) - Automated Password Generator\n" >> /etc/motd && \
    printf "  * bosh (${BOSH_CLI_VERSION}) - Bosh CLI (https://bosh.io/docs/cli-v2.html)\n" >> /etc/motd && \
    printf "  * cf (${CF_CLI_VERSION}) - Cloud Foundry CLI (https://github.com/cloudfoundry/cli)\n" >> /etc/motd && \
    printf "  * credhub (${CREDHUB_VERSION}) - Credhub CLI (https://github.com/cloudfoundry-incubator/credhub-cli)\n" >> /etc/motd && \
    printf "  * fly (${FLY_VERSION}) - Concourse CLI (https://github.com/concourse/fly)\n" >> /etc/motd && \
    printf "  * git (${GIT_VERSION}) - Git client\n" >> /etc/motd && \
    printf "  * jq (${JQ_VERSION}) - JSON processing Tool (https://stedolan.github.io/jq/)\n" >> /etc/motd && \
    printf "  * spruce (${SPRUCE_VERSION}) - YAML templating tool (https://github.com/geofffranks/spruce)\n" >> /etc/motd && \
    printf "  * terraform (${TERRAFORM_VERSION}) - Provides a common configuration to launch infrastructure (https://www.terraform.io/)\n" >> /etc/motd && \
    printf "  * uaac (${CF_UAAC_VERSION}) - Cloud Foundry UAA CLI (https://github.com/cloudfoundry/cf-uaac)\n" >> /etc/motd && \
    printf 'Admin tools:\n' >> /etc/motd && \
    printf "  * bbr (${BBR_VERSION}) - Bosh Backup and Restore CLI (http://docs.cloudfoundry.org/bbr/)\n" >> /etc/motd && \
    printf "  * gof3r (${S3GOFR_VERSION}) - Client for fast, parallelized and pipelined streaming access to S3 bucket (https://github.com/rlmcpherson/s3gof3r)\n" >> /etc/motd && \
    printf "  * mysqlsh (${MYSQL_SHELL_VERSION}) - MySQL shell CLI (https://dev.mysql.com/doc/mysql-shell-excerpt/5.7/en/)\n" >> /etc/motd && \
    printf "  * mongo (${MONGO_SHELL_VERSION}) - MongoDB shell CLI (https://docs.mongodb.com/manual/mongo/)\n" >> /etc/motd && \
    printf "  * mc (${MINIO_VERSION}) - Minio S3 CLI (https://github.com/minio/mc)\n" >> /etc/motd && \
    printf "  * shield (${SHIELD_VERSION}) - Shield CLI (https://docs.pivotal.io/partners/starkandwayne-shield/)\n" >> /etc/motd && \
    printf 'Kubernetes tools:\n' >> /etc/motd && \
    printf "  * helm (${HELM_VERSION}) - Kubernetes Package Manager (https://docs.helm.sh/)\n" >> /etc/motd && \
    printf "  * kubectl (${KUBECTL_VERSION}) - Kubernetes CLI (https://kubernetes.io/docs/reference/generated/kubectl/overview/)\n" >> /etc/motd && \
    printf "  * smctl (${PERIPLI_VERSION}) - Service Manager CLI (https://github.com/Peripli/service-manager-cli/#service-manager-cli)\n" >> /etc/motd && \
    printf '\nNotes :\n' >> /etc/motd && \
    printf '  * "tools" command tells you about the available tools.\n' >> /etc/motd && \
    printf '  * "/data/shared" is a persistant data docker volume, shared with other container instances.\n' >> /etc/motd && \
    printf '  * All other paths in this container will be reseted on restart/update (do not save data on it).\n\n' >> /etc/motd && \
    printf '\n=====================================================\n=> Set rights and cleanup docker image\n=====================================================\n' && \
    chmod 755 /usr/local/bin/* /etc/profile.d/* && chmod 644 /etc/motd && \
    mv /tmp/profile /home/bosh/.profile && chmod 664 /home/bosh/.profile && \
    touch /var/log/lastlog && chgrp utmp /var/log/lastlog && chmod 664 /var/log/lastlog && \
    mkdir -p /home/bosh/.ssh  && chmod 700 /home/bosh/.ssh && chmod 700 /home/bosh && \
    find /home/bosh /data -print0 | xargs -0 chown bosh:users && \
    rm -fr /tmp/* /var/tmp/* && find /var/log -type f -delete

#--- Launch supervisord daemon
CMD /usr/local/bin/supervisord.sh
EXPOSE 22