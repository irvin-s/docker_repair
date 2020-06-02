# TeX Live
#
# @link     http://www.tug.org/texlive
# @version 	latest (2014)
# @author 	leodido <leodidonato@gmail.com>
FROM centos:centos6

MAINTAINER Leonardo Di Donato, leodidonato@gmail.com

# Deps installation
RUN yum install -y wget tar perl fontconfig
# envinronment
ENV TL install-tl
RUN mkdir -p $TL
# texlive net batch installation
RUN wget -nv -O $TL.tar.gz http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN tar -xzf $TL.tar.gz -C $TL --strip-components=1
ADD full.profile $TL/
RUN cd $TL/ && ./install-tl --persistent-downloads --profile full.profile
RUN ln -s /usr/local/texlive/2014/bin/x86_64-linux /opt/texbin
ENV PATH $PATH:/usr/local/texlive/2014/bin/x86_64-linux
# cleanup
RUN rm $TL.tar.gz && rm -r $TL
# tex fonts installation
RUN cp $(kpsewhich -var-value TEXMFSYSVAR)/fonts/conf/texlive-fontconfig.conf /etc/fonts/conf.d/09-texlive.conf
RUN fc-cache -fsv
