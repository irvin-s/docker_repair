FROM fedora:28
LABEL MAINTAINER mail@kushaldas.in

RUN dnf -y update
RUN dnf install -y perl-Image-ExifTool GraphicsMagick
RUN dnf install -y ghostscript-core


ENV HOME /home/pdfuser
RUN useradd --create-home --home-dir $HOME pdfuser \
    && mkdir $HOME/workplace \
    && chown -R pdfuser:pdfuser $HOME

COPY ./target/debug/safepdf /usr/bin/

WORKDIR $HOME/workplace
VOLUME $HOME/workplace
USER pdfuser
CMD ["bash"]
