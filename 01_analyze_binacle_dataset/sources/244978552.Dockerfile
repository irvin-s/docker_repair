FROM rtndocker/rtndfcore
WORKDIR /root/rtndf/Python/uvccam
ADD . .
ENTRYPOINT ["python", "uvccam.py", "-x", "-y"]




