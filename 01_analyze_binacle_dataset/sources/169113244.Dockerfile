FROM nacyot/ocaml-ocaml:apt

RUN \
  add-apt-repository ppa:avsm/ppa &&\
  apt-get update &&\
  apt-get install -y opam

RUN \
  apt-get install -y libzmq3 libzmq3-dev python python-pip python-zmq python-jinja2 python-tornado libmagickwand-dev m4 zlib1g-dev camlp4-extra libssl-dev libffi-dev &&\
  pip install ipython==1.1.0

RUN \
  opam init -a &&\
  opam update &&\
  opam install -y iocaml iocaml-kernel

RUN git clone https://github.com/andrewray/iocaml.git /root/iocaml

RUN \
  bash -cl "ipython profile create iocaml" &&\
  cp -r /root/iocaml/profile/* `ipython locate profile iocaml`

ENV CAML_LD_LIBRARY_PATH /root/.opam/system/lib/stublibs:/usr/lib/ocaml/stublibs
ENV PATH /root/.opam/system/bin:$PATH

VOLUME /root/notebooks
EXPOSE 8888
CMD ipython notebook --profile=iocaml --ip=0.0.0.0 --notebook-dir=/root/notebooks

