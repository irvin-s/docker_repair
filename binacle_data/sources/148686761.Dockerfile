FROM ubuntu:19.04

# Packages
RUN apt-get update && apt-get install --no-install-recommends -y \
    gpg \
    curl \
    wget \
    lsb-release \
    add-apt-key \
    ca-certificates \
    dumb-init \
    && rm -rf /var/lib/apt/lists/*

# CF CLI
RUN curl -sS -o - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add \
    && echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list \
    && apt-get update && apt-get install --no-install-recommends -y cf-cli \
    && rm -rf /var/lib/apt/lists/*

# Helm CLI
RUN curl "https://raw.githubusercontent.com/helm/helm/master/scripts/get" | bash

# Kubectl CLI
RUN curl -sL "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

# Azure CLI
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list \
    && apt-get update && apt-get install --no-install-recommends -y azure-cli \
    && rm -rf /var/lib/apt/lists/*

# Common SDK
RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    sudo \
    gdb \
    pkg-config \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Node SDK
RUN apt-get update && apt-get install --no-install-recommends -y \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Golang SDK
RUN apt-get update && apt-get install --no-install-recommends -y \
    golang-1.12 \
    && rm -rf /var/lib/apt/lists/*

# Python SDK
RUN apt-get update && apt-get install --no-install-recommends -y \
    python3 \
    python-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade setuptools \
    && python3 -m pip install wheel \
    && python3 -m pip install -U pylint

# Java SDK
RUN apt-get update && apt-get install --no-install-recommends -y \
    default-jre-headless \
    default-jdk-headless \
    maven \
    gradle \
    && rm -rf /var/lib/apt/lists/*

# .NET Core SDK
# RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
# RUN echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/18.04/prod $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/microsoft-prod.list
# RUN apt-get update && apt-get install --no-install-recommends -y \
#    libunwind8 \
#    dotnet-sdk-2.2 \
#    && rm -rf /var/lib/apt/lists/*

# Chromium
RUN apt-get update && apt-get install --no-install-recommends -y \
    chromium-browser \
    && rm -rf /var/lib/apt/lists/*

# Chrome
# RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
# RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
# RUN apt-get update && apt-get install --no-install-recommends -y \
#    google-chrome-stable \
#    && rm -rf /var/lib/apt/lists/*

# Code-Server
RUN apt-get update && apt-get install --no-install-recommends -y \
    bsdtar \
    openssl \
    locales \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
ENV DISABLE_TELEMETRY true

ENV CODE_VERSION="1.1119-vsc1.33.1"
RUN curl -sL https://github.com/cdr/code-server/releases/download/${CODE_VERSION}/code-server${CODE_VERSION}-linux-x64.tar.gz | tar --strip-components=1 -zx -C /usr/local/bin code-server${CODE_VERSION}-linux-x64/code-server

# Setup User
RUN groupadd -r coder \
    && useradd -m -r coder -g coder -s /bin/bash \
    && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd
USER coder

# Setup User Go Environment
RUN mkdir /home/coder/go
ENV GOPATH "/home/coder/go"
ENV PATH "${PATH}:/usr/local/go/bin:/home/coder/go/bin"

# Setup Uset .NET Environment
# ENV DOTNET_CLI_TELEMETRY_OPTOUT "true"
# ENV MSBuildSDKsPath "/usr/share/dotnet/sdk/2.2.202/Sdks"
# ENV PATH "${PATH}:${MSBuildSDKsPath}"

# Setup User Visual Studio Code Extentions
ENV VSCODE_USER "/home/coder/.local/share/code-server/User"
ENV VSCODE_EXTENSIONS "/home/coder/.local/share/code-server/extensions"

RUN mkdir -p ${VSCODE_USER}
COPY --chown=coder:coder settings.json /home/coder/.local/share/code-server/User/

# Setup Go Extension
RUN mkdir -p ${VSCODE_EXTENSIONS}/go \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode/vsextensions/Go/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/go extension

# Setup Python Extension
RUN mkdir -p ${VSCODE_EXTENSIONS}/python \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/python/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/python extension

# Setup Java Extension
RUN mkdir -p ${VSCODE_EXTENSIONS}/java \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/redhat/vsextensions/java/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/java extension

RUN mkdir -p ${VSCODE_EXTENSIONS}/java-debugger \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vscjava/vsextensions/vscode-java-debug/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/java-debugger extension

RUN mkdir -p ${VSCODE_EXTENSIONS}/java-test \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vscjava/vsextensions/vscode-java-test/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/java-test extension

RUN mkdir -p ${VSCODE_EXTENSIONS}/maven \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vscjava/vsextensions/vscode-maven/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/maven extension

# Setup Kubernetes Extension
RUN mkdir -p ${VSCODE_EXTENSIONS}/yaml \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/redhat/vsextensions/vscode-yaml/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/yaml extension

RUN mkdir -p ${VSCODE_EXTENSIONS}/kubernetes \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-kubernetes-tools/vsextensions/vscode-kubernetes-tools/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/kubernetes extension

RUN helm init --client-only

# Setup Browser Preview
RUN mkdir -p ${VSCODE_EXTENSIONS}/browser-debugger \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/msjsdiag/vsextensions/debugger-for-chrome/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/browser-debugger extension

RUN mkdir -p ${VSCODE_EXTENSIONS}/browser-preview \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/auchenberg/vsextensions/vscode-browser-preview/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/browser-preview extension

# Setup User Workspace
RUN mkdir -p /home/coder/project
WORKDIR /home/coder/project

ENTRYPOINT ["dumb-init", "code-server"]