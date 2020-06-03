FROM rtndocker/rtndfcore

ADD . /root/rtndf/Cpp/imuview

WORKDIR /root/rtndf/Cpp/imuview
RUN qmake
RUN make clean
RUN make -j8
RUN make install
RUN make clean

RUN ldconfig

ENTRYPOINT ["imuview"]
CMD ["-s/.config/Manifold/ImuView.ini"]


