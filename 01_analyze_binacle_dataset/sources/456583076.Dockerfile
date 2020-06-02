FROM quay.io/openshiftio/rhel-base-fabric8-analytics-server:latest
LABEL maintainer "Devtools <devtools@redhat.com>"
LABEL author "Devtools <devtools@redhat.com>"

ENV LANG=en_US.UTF-8 \
    F8A_WORKER_VERSION=d403113 \
    F8A_AUTH_VERSION=5211e23 \
    F8A_UTILS=f94a04e

RUN useradd -d /coreapi coreapi

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
