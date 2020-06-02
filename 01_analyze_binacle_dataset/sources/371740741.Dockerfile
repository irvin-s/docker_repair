FROM daocloud.io/hycf555/python2-opencv3:master-d47fa11

RUN pip install jupyter matplotlib tensorflow Pillow

ENV PORT=8888
ENV LOG_LEVEL=INFO
ENV NOTEBOOK_DIR=/notebooks

RUN mkdir $NOTEBOOK_DIR
VOLUME $NOTEBOOK_DIR
WORKDIR $NOTEBOOK_DIR

EXPOSE $PORT

ENTRYPOINT ["sh", "-c", "jupyter notebook --ip 0.0.0.0 --port ${PORT} --no-browser --log-level ${LOG_LEVEL} --notebook-dir $NOTEBOOK_DIR"]
