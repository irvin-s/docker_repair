FROM rtndocker/manifoldcore

ADD . /root/rtndf/rtndfcore

WORKDIR /root/rtndf/rtndfcore
RUN ./buildns







