FROM registry.centos.org/centos/centos:7

ENV LANG=en_US.UTF-8 \
    F8A_WORKER_VERSION=d403113 \
    F8A_AUTH_VERSION=5211e23 \
    F8A_UTILS=f94a04e

RUN useradd -d /coreapi coreapi

# https://copr.fedorainfracloud.org/coprs/fche/pcp/
# https://copr.fedorainfracloud.org/coprs/jpopelka/mercator/
COPY hack/_copr_fche_pcp.repo hack/_copr_jpopelka-mercator.repo /etc/yum.repos.d/

# python3-pycurl is needed for Amazon SQS (boto lib), we need CentOS' rpm - installing it from pip results in NSS errors
RUN yum install -y epel-release &&\
    yum --setopt=skip_missing_names_on_install=False install -y gcc patch git python36-pip python36-requests httpd httpd-devel python36-devel postgresql-devel redhat-rpm-config libxml2-devel libxslt-devel python36-pycurl pcp mercator openssl-devel &&\
    yum clean all

COPY ./requirements.txt /coreapi/
RUN pushd /coreapi && \
    pip3 install -r requirements.txt && \
    rm requirements.txt && \
    popd

COPY ./coreapi-httpd.conf /etc/httpd/conf.d/

# Create & set pcp dirs
RUN mkdir -p /etc/pcp /var/run/pcp /var/lib/pcp /var/log/pcp  && \
    chgrp -R root /etc/pcp /var/run/pcp /var/lib/pcp /var/log/pcp && \
    chmod -R g+rwX /etc/pcp /var/run/pcp /var/lib/pcp /var/log/pcp

COPY ./ /coreapi
RUN pushd /coreapi && \
    pip3 install --upgrade pip>=10.0.0 && pip3 install . &&\
    popd

RUN pip3 install git+https://github.com/fabric8-analytics/fabric8-analytics-worker.git@${F8A_WORKER_VERSION}
RUN pip3 install git+https://github.com/fabric8-analytics/fabric8-analytics-auth.git@${F8A_AUTH_VERSION}
RUN pip3 install git+https://github.com/fabric8-analytics/fabric8-analytics-utils.git@${F8A_UTILS}

# Required by the solver task in worker to resolve dependencies from package.json
RUN npm install -g semver-ranger

COPY .git/ /tmp/.git
# date and hash of last commit
RUN cd /tmp/.git &&\
    git show -s --format="COMMITTED_AT=%ai%nCOMMIT_HASH=%h%n" HEAD | tee /etc/coreapi-release &&\
    rm -rf /tmp/.git/

COPY hack/coreapi-server.sh hack/server+pmcd.sh /usr/bin/

EXPOSE 44321

CMD ["/usr/bin/server+pmcd.sh"]

