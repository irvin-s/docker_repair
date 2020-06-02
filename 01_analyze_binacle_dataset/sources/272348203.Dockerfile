FROM amazonlinux

RUN echo $'\n\n===> Installing Node 8.x' \
  && curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - \
  && yum -y install nodejs \
  && echo $'\n\n===> Installing pkg and pkg-fetch' \
  && npm install --global pkg pkg-fetch \
  && echo $'\n\n===> Using pkg-fetch to download the base binaries of Node 8' \
  && pkg-fetch node8 linux x86_64 \
  && echo $'\n\n===> Done!'