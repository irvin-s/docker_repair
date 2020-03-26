FROM evarga/jenkins-slave
MAINTAINER Pit Kleyersburg <pitkley@googlemail.com>

# This docker-file is pretty much a carbon copy of Leonardo Di Donato's
# image `leodido/texlive`, just based on `evarga:jenkins-slave` and thus
# adapted to `apt-get`.

RUN apt-get update && apt-get install -y --no-install-recommends git wget fontconfig \
        && rm -rf /var/lib/apt/lists/*

ENV TL install-tl-2015

RUN mkdir -p $TL
ADD full.profile $TL/

RUN cd $TL/ \
    && wget -nv -O $TL.tar.gz http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    && tar -xzf $TL.tar.gz --strip-components=1 \
    && ./install-tl --persistent-downloads --profile full.profile \
    && cd / \
    && rm -rf $TL

ENV PATH $PATH:/usr/local/texlive/2015/bin/x86_64-linux

RUN [ -f $(kpsewhich -var-value TEXMFSYSVAR)/fonts/conf/texlive-fontconfig.conf ] && cp $(kpsewhich -var-value TEXMFSYSVAR)/fonts/conf/texlive-fontconfig.conf /etc/fonts/conf.d/09-texlive.conf || :
RUN fc-cache -fsv

