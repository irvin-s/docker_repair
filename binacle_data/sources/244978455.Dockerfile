FROM bamos/openface
RUN apt-get update && apt-get install -y \
    build-essential \
    qt5-default \
    net-tools \
    iputils-ping \
    nano \
    python-dev \
    git
    
RUN git clone git://github.com/richardstechnotes/Manifold

WORKDIR /Manifold/ManifoldPythonLib
RUN qmake
RUN make clean
RUN make -j8
RUN make install
RUN python setup.py build
RUN python setup.py install

WORKDIR /
RUN git clone git://github.com/richardstechnotes/rtndf

WORKDIR /rtndf/rtndfcore/Python
RUN python setup.py build
RUN python setup.py install

WORKDIR /root
RUN git clone git://github.com/richardstechnotes/rtndf
WORKDIR /root/src/facerec
RUN cp -r /root/rtndf/Python/facerec/* .

RUN ./get-models.sh
ENTRYPOINT ["/bin/bash", "-c", "-l", "python facerec.py -x -y"]






