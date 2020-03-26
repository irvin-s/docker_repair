FROM base/archlinux
MAINTAINER Denis Costa

RUN pacman -Sy --noconfirm
RUN pacman -S --noconfirm sudo

RUN mkdir -p /src/
WORKDIR /src/
COPY . /src/

RUN bash -c "USER=root HOME=/root DEBUG=1 NO_GPG_VERIFY=1 /src/deploy.sh"
