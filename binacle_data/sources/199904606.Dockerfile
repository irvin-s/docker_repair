FROM bitnami/minideb-extras:jessie

ENV PATH="/opt/bitnami/git/bin:$PATH"

RUN install_packages build-essential pkg-config unzip
RUN bitnami-pkg install git-2.17.1-0 --checksum 948b00c283f89cac532ee3b2cd26b3efde12fe5425f25c6d836a96cebd35a8a7
