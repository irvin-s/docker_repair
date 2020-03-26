FROM rtndocker/manifoldcoretf

ADD . /root/rtndf/rtndfcore

WORKDIR /root/rtndf/rtndfcore
RUN ./buildns







