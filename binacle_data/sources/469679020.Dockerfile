FROM hub.baidubce.com/openedge/openedge-function-python27-builder:0.1.3
WORKDIR /
COPY openedge-function-python27.py function_pb2.py function_pb2_grpc.py /bin/
RUN chmod +x /bin/openedge-function-python27.py
ENTRYPOINT ["openedge-function-python27.py"]
