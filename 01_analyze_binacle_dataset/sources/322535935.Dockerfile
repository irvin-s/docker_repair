FROM debian:stretch-slim
MAINTAINER Benjamin Neff <benjamin@coding4coffee.ch>

COPY . /k8s-info
WORKDIR /k8s-info

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pkg-resources \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        curl \
        gnupg \
        apt-transport-https && \
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo 'deb https://deb.nodesource.com/node_10.x stretch main' > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    npm install && \
    npm run-script build && \
    rm node_modules -rf && \
    pip3 install -r requirements.txt && \
    apt-get purge -y \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        curl \
        gnupg \
        apt-transport-https \
        nodejs && \
    apt-get --purge autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* && \
    useradd -ms /bin/bash k8s-info

USER k8s-info
WORKDIR /k8s-info/app

VOLUME ["/home/k8s-info/.kube"]
EXPOSE 8000

CMD gunicorn -w 4 -b 0.0.0.0:8000 k8s-info:app
