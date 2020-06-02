FROM fedora
RUN dnf update -y
RUN dnf install -y make golang gcc rpm-build rpm git fedora-packager fedora-review @development-tools
RUN groupadd sii2pplugin
RUN adduser --system --home-dir /home/sii2pplugin -g sii2pplugin sii2pplugin
COPY . /home/sii2pplugin/si-i2p-plugin
RUN chown -R sii2pplugin:sii2pplugin /home/sii2pplugin
WORKDIR /home/sii2pplugin/si-i2p-plugin
USER sii2pplugin
RUN go get github.com/eyedeekay/gosam
RUN make
CMD find / -name rpm
