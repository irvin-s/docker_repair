FROM chryswoods/acquire-base:latest

# Need to be user root or Fn exits with
# {"message":"internal server error"}
USER root

WORKDIR $HOME
RUN mkdir $PYTHON_EXT/storage

ADD *.py $PYTHON_EXT/storage/
RUN python3 -m compileall $PYTHON_EXT/storage/*.py

ADD route.py secret_key ./

ENTRYPOINT ["python", "route.py"]
