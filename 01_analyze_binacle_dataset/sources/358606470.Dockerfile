FROM kaixhin/cuda-caffe:7.0
MAINTAINER Matt Edwards <matted@mit.edu>

RUN apt-get update
RUN apt-get install -y emacs24-nox nano curl

# Set up the appropriate Python environment with conda.
RUN curl -sS https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh > /root/miniconda.sh
RUN chmod a+x /root/miniconda.sh
RUN /root/miniconda.sh -b
ENV PATH /root/miniconda2/bin:$PATH
RUN conda install scipy numpy matplotlib=1.3.1 pil # matplotlib=1.3.1 downgrades everything

# Bring DeepBind source code into the image.
COPY code/libs /root/deepbind/libs

# Build the DeepBind binaries.
RUN make --directory /root/deepbind/libs/smat/src clean
RUN make --directory /root/deepbind/libs/smat/src
RUN make --directory /root/deepbind/libs/deepity/deepity_smat clean
RUN make --directory /root/deepbind/libs/deepity/deepity_smat
RUN make --directory /root/deepbind/libs/kangaroo/kangaroo_smat clean
RUN make --directory /root/deepbind/libs/kangaroo/kangaroo_smat

ENV LD_LIBRARY_PATH /root/deepbind/libs/deepity/build/release/bin:/root/deepbind/libs/smat/build/release/bin:/root/deepbind/libs/kangaroo/build/release/bin:$LD_LIBRARY_PATH

# Bring in DeepBind data and scripts.
COPY code/*py /root/deepbind/
COPY code/cfg /root/deepbind/cfg
COPY data /root/data

WORKDIR /root/deepbind

CMD python deepbind_train_encode.py top calib,train,test,report
