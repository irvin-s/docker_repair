FROM fedora:latest

MAINTAINER ssato "https://github.com/ssato"

RUN dnf install -y dnf-plugins-core && mkdir -p /etc/yum.repos.d/
RUN dnf copr enable -y ssato/python-anyconfig
RUN dnf install -y \
  graphviz hardlink libosinfo python-BeautifulSoup python-anyconfig \
  python-bunch python-networkx rpm-python yum-plugin-downloadonly \
  yum-plugin-security python-flake8 PyYAML python-pep8 pylint \
  python-pip git gobject-introspection python-tablib
RUN pip install --use-mirrors coveralls

RUN git clone https://github.com/ssato/rpmkit.git /root/rpmkit
