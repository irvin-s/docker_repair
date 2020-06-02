# Copyright 2017 The Gardener Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:16.04

RUN apt-get update && apt-get install -y jq gnupg2 python python-mako curl groff \
    zip unzip git iputils-ping python-pip apache2-utils vim bash-completion && \
    curl -L "https://github.com/bronze1man/yaml2json/releases/download/v1.2/yaml2json_linux_amd64" -o /usr/local/bin/yaml2json && \
    curl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 -o /usr/local/bin/cfssl && \
    curl https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 -o /usr/local/bin/cfssljson && \
    curl https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip -o terraform.zip && \
    unzip terraform.zip && mv terraform /usr/local/bin && rm terraform.zip && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    mv kubectl /usr/local/bin && \
    git clone https://github.com/yaml/pyyaml.git pyyaml && cd pyyaml && \
    python setup.py --without-libyaml install && \
    cd .. && rm -rf pyyaml && \
    pip install awscli --ignore-installed pyyaml && \
    curl -O https://kubernetes-helm.storage.googleapis.com/helm-v2.10.0-linux-amd64.tar.gz && \
    tar xfv helm-*linux-amd64.tar.gz && mv linux-amd64/helm /usr/local/bin && rm -rf linux-amd64 && \
    curl -LO https://github.com/cloudfoundry-incubator/spiff/releases/download/v1.0.8/spiff_linux_amd64.zip && \
    unzip spiff_linux_amd64.zip && mv spiff /usr/local/bin && rm -rf spiff_linux_amd64.zip && \
    echo "alias k='kubectl' \nalias kn='kubectl -n' \nalias ks='kubectl -n kube-system' \nalias kg='kubectl -n garden' \nalias ka='kubectl get --all-namespaces'" >> ~/.bash_aliases && \
    echo "\nsource <(/usr/local/bin/kubectl completion bash) \nsource /etc/bash_completion" >> ~/.bash_aliases && \
    echo "for x in k kn ks kg; do \n  complete -o default -F __start_kubectl \$x \ndone" >> ~/.bash_aliases && \
    echo "\n\nTERM=xterm-256color" >> ~/.bashrc && \
    sed -i -e "s/#force_color_prompt=yes/force_color_prompt=yes/g" ~/.bashrc && \
    chmod 755 /usr/local/bin/*
