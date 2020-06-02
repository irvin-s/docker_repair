FROM alpine:latest

RUN apk add --no-cache \
    bash \
    bash-completion \
    bats \
    coreutils \
    curl \
    git \
    groff \
    jq \
    less \
    openssh-client \
    python3 \
    ncurses \
    vim

WORKDIR /root/aladdin
COPY ./commands/python/requirements.txt ./commands/python/requirements.txt
RUN pip3 install --no-cache-dir -r ./commands/python/requirements.txt

# update all needed tool versions here
ARG KUBE_VERSION=1.11.5
ARG KOPS_VERSION=1.11.0-beta.1
ARG HELM_VERSION=2.11.0

RUN	curl -L -o /bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v$KUBE_VERSION/bin/linux/amd64/kubectl \
	&& chmod 755 /bin/kubectl

RUN	curl -L -o /bin/kops https://github.com/kubernetes/kops/releases/download/$KOPS_VERSION/kops-linux-amd64 \
	&& chmod 755 /bin/kops

RUN	curl -L -o- https://storage.googleapis.com/kubernetes-helm/helm-v$HELM_VERSION-linux-amd64.tar.gz | tar -zxvf - && cp linux-amd64/helm \
	/bin/helm && chmod 755 /bin/helm && helm init --client-only

ENV PATH="/root/.local/bin:/root:${PATH}"
COPY . /root/aladdin
