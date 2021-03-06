FROM python:2.7.16-alpine3.9 AS compile-image
ARG TERRAFORM_VERSION="0.11.7"

ENV BOTO_CONFIG=/dev/null
COPY . /sources/
WORKDIR /sources

RUN wget -q -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform.zip -d /usr/local/bin \
    && rm -rf terraform.zip
RUN apk add --virtual=build bash gcc libffi-dev musl-dev openssl-dev make
RUN ln -s /usr/local/bin/python /usr/bin/python
RUN bash build_scripts/freeze_requirements.sh
RUN bash build_scripts/run_tests.sh
RUN bash build_scripts/build_package.sh
RUN apk del --purge build


FROM python:2.7.16-alpine3.9
ARG HELM_VERSION="v2.13.1"
ARG KUBECTL_VERSION="v1.13.4"
ARG TERRAFORM_VERSION="0.11.7"
ARG VAULT_VERSION="1.1.1"
ARG AWS_IAM_AUTHENTICATOR_VERSION="1.12.7/2019-03-27"

COPY --from=compile-image /sources/dist /dist

RUN adduser ops -Du 2342 -h /home/ops \
    && ln -s /usr/local/bin/python /usr/bin/python \
    && apk add --no-cache bash ca-certificates curl jq openssh-client git \
    && apk add --virtual=build gcc libffi-dev musl-dev openssl-dev make \
    # Install ops python package
    && pip --no-cache-dir install --upgrade /dist/ops-*.tar.gz \
    && rm -rf /dist \
    && apk del --purge build \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && wget -q -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform.zip -d /usr/local/bin \
    && rm -rf terraform.zip \
    && mkdir -p  ~/.terraform.d/plugins && wget -q -O ~/.terraform.d/plugins/terraform-provider-vault https://github.com/amuraru/terraform-provider-vault/releases/download/vault-namespaces/terraform-provider-vault \
    && chmod 0755 ~/.terraform.d/plugins/terraform-provider-vault \
    && wget -q -O vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
    && unzip vault.zip -d /usr/local/bin \
    && rm -rf vault.zip \
    && wget -q https://amazon-eks.s3-us-west-2.amazonaws.com/${AWS_IAM_AUTHENTICATOR_VERSION}/bin/linux/amd64/aws-iam-authenticator -O /usr/local/bin/aws-iam-authenticator \
    && chmod +x /usr/local/bin/aws-iam-authenticator

USER ops
ENV HOME=/home/ops
WORKDIR /home/ops
RUN helm init --client-only
CMD /bin/bash


