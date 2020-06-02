FROM fedora:22

MAINTAINER Christoph Görn <goern@b4mad.net>

LABEL Vendor="#B4mad.Net" License=GPLv2
LABEL Version=1.4.3

ENV container docker

RUN dnf install -y --setopt=tsflags=nodocs tar gcc-c++ rubygem-nokogiri rubygem-asciidoctor asciidoc fop docbook-xsl ditaa java-1.8.0-openjdk-devel ruby-devel zlib-devel google-noto-serif-fonts && \
    dnf group install -y --setopt=tsflags=nodocs "Development Tools" && \
    dnf update -y --setopt=tsflags=nodocs && \
    dnf clean all

# we need this for some gem native extensions
ENV JAVA_HOME /etc/alternatives/java_sdk_1.8.0_openjdk
ENV PATH /usr/bin:/usr/local/bin:/etc/alternatives/java_sdk_1.8.0_openjdk

RUN gem install --no-ri --no-rdoc rjb guard guard-shell guard-livereload rb-readline && \
    gem install --no-ri --no-rdoc asciidoctor-epub3 --version 1.5.0.alpha.4 && \
    gem install --no-ri --no-rdoc asciidoctor-pdf --version 1.5.0.alpha.9 && \
    gem install --no-ri --no-rdoc --pre asciidoctor-diagram && \
    gem install --no-ri --no-rdoc coderay pygments.rb thread_safe epubcheck kindlegen && \
    gem install --no-ri --no-rdoc slim haml tilt
RUN    dnf install -y --setopt=tsflags=nodocs wget python-devel zlib-devel
RUN    wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | python && \
    easy_install "blockdiag[pdf]" && \
    easy_install seqdiag && \
    easy_install actdiag && \
    easy_install nwdiag
RUN    dnf group remove -y "Development Tools" && \
    dnf remove -y wget python-devel zlib-devel tar && \
    dnf clean all

RUN mkdir /etc/asciinurse.d
ADD Guardfile /etc/asciinurse.d/Guardfile
ADD asciidoc.conf /etc/asciidoc/asciidoc.conf

# add themes we want to use...
ADD rh-ra-asciidoctor-theme.yml /usr/local/share/gems/gems/asciidoctor-pdf-1.5.0.alpha.9/data/themes/rh-ra-theme.yml

VOLUME /documents
WORKDIR /documents

EXPOSE 35729

CMD [ "guard", "-di", "--no-notify", "--watchdir", "/documents", "--guardfile", "/etc/asciinurse.d/Guardfile" ]
