FROM rtndocker/manifoldcoretfgpu

ADD . /root/rtndf/rtndfcore

WORKDIR /root/rtndf/rtndfcore
RUN ./buildns







