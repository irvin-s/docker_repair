FROM rtndocker/rtndfcoretfcv2
    
WORKDIR /root/rtndf/Python/recognize
ADD . .
ENTRYPOINT ["python", "recognize.py", "-x", "-y"]




