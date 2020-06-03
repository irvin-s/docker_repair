FROM jupyter/all-spark-notebook:033056e6d164

# last update: Sat Dec 29 13:50:00 EST 2018
# p6steve 0.0.1 

USER root

ENV NB_USER jovyan
ENV NB_UID 100
ENV HOME /home/${NB_USER}

RUN apt-get update \
  && apt-get install -y build-essential \
  && git clone https://github.com/rakudo/rakudo.git -b 2017.12 \
  && cd rakudo && perl Configure.pl --prefix=/usr --gen-moar --gen-nqp --backends=moar \
  && make && make install && cd .. && rm -rf rakudo \
  && export PATH=$PATH:/usr/share/perl6/site/bin \
  && git clone https://github.com/ugexe/zef.git \
     && cd zef && perl6 -Ilib bin/zef install . \
     && cd .. && rm -rf zef \
  && zef -v install https://github.com/bduggan/p6-jupyter-kernel.git@0.0.9 \
  && zef -v install SVG::Plot --force-test \
  && zef -v install https://github.com/p6steve/perl6-Math-Polygons.git \
  && git clone https://github.com/p6steve/perl6-Math-Polygons.git \
  && mv perl6-Math-Polygons/eg ${HOME} \
  && rm -rf perl6-Math-Polygons \
  && chown -R $NB_UID ${HOME} \
  && fix-permissions ${HOME} \
  && jupyter-kernel.p6 --generate-config

ENV PATH /usr/share/perl6/site/bin:$PATH

USER ${NB_USER}

