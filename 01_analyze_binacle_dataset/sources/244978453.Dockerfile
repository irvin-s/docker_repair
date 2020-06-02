FROM rtndocker/rtndfcore
WORKDIR /root/rtndf/Python/avview
ADD . .
ENTRYPOINT ["python", "avview.py"]




