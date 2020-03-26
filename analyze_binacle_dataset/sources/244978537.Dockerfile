FROM rtndocker/rtndfcoretfcv2
WORKDIR /root/rtndf/Python/modet
ADD . .
ENTRYPOINT ["python", "modet.py", "-x", "-y"]




