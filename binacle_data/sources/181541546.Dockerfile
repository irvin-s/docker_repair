FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
    make \
    texlive-xetex \
    texlive-latex-recommended \
    texlive-lang-german \
    texlive-latex-extra

# maybe the fonts can be published in the repo directly?
RUN apt-get update && apt-get install -y \
    wget \
    unzip
ENV EUROSTILE_FONTS_DIR /usr/share/fonts/truetype/EurostileLTStd
RUN mkdir -p $EUROSTILE_FONTS_DIR && \
    wget -O $EUROSTILE_FONTS_DIR/font.zip \
        https://public.centerdevice.de/download/fabd322d-bc1d-4b1b-bcae-c6dd2426660f.b89bbafa-7f0d-417e-9b4b-e73d32cf4bdf && \
    unzip $EUROSTILE_FONTS_DIR/font.zip -d $EUROSTILE_FONTS_DIR && \
    rm $EUROSTILE_FONTS_DIR/font.zip

ENV PANTON_FONTS_DIR /usr/share/fonts/truetype/Panton
RUN mkdir -p $PANTON_FONTS_DIR && \
    wget -O $PANTON_FONTS_DIR/font.zip \
        https://public.centerdevice.de/download/7be514e9-531c-4c5e-b3bd-998298450f7e.292bf557-121c-4798-a837-ebbe2ddd1571 && \
    unzip $PANTON_FONTS_DIR/font.zip -d $PANTON_FONTS_DIR && \
    rm $PANTON_FONTS_DIR/font.zip

ADD . /opt

WORKDIR /opt

CMD ["make", "cv"]
