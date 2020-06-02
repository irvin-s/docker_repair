FROM rtndocker/rtndfcoretfgpu
WORKDIR /root/rtndf/Python/imageproc
ADD . .
ENTRYPOINT ["python", "imageproc.py", "-x", "-y"]




