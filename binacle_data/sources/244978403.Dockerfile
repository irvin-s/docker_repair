FROM rtndocker/rtndfcore
RUN apt-get update && apt-get install -y \
    autotools-dev \
    libtool \
    automake \
    bison \
    swig \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN git clone git://github.com/cmusphinx/sphinxbase
RUN git clone git://github.com/cmusphinx/pocketsphinx

WORKDIR /root/sphinxbase
RUN ./autogen.sh
RUN ./configure
RUN make -j8
RUN make install

WORKDIR /root/pocketsphinx
RUN ./autogen.sh
RUN ./configure
RUN make -j8
RUN make install

ADD . /root/rtndf/Cpp/speechdecode

WORKDIR /root/rtndf/Cpp/speechdecode
RUN qmake
RUN make clean
RUN make -j8
RUN make install
RUN make clean

RUN ldconfig

ENTRYPOINT ["speechdecode"]
CMD ["-s/.config/Manifold/SpeechDecode.ini"]


