FROM ubuntu
MAINTAINER Matt Erasmus <code@zonbi.org>
RUN addgroup reconng
RUN useradd -r -g reconng -G sudo -d /opt/recon-ng -s /bin/bash -c "ReconNG User" reconng
RUN echo "reconng:toor" | chpasswd
RUN apt-get update
RUN apt-get install -yq git python-pip python2.7-dev libxslt1-dev zlib1g zlib1g-dev openssh-server
RUN git clone https://LaNMaSteR53@bitbucket.org/LaNMaSteR53/recon-ng.git /opt/recon-ng
WORKDIR /opt/recon-ng
RUN pip install -r REQUIREMENTS
RUN chown reconng:reconng -R /opt/recon-ng
RUN service ssh start
USER reconng
ADD add_keys.rc /opt/recon-ng/add_keys.rc
ENTRYPOINT ["/usr/bin/python"]
CMD ["/opt/recon-ng/recon-ng"]
