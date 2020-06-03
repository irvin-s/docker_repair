FROM chryswoods/acquire-base:latest

# Need to be user root or Fn exits with
# {"message":"internal server error"}
USER root

WORKDIR $HOME
RUN mkdir $PYTHON_EXT/registry

ADD *.py $PYTHON_EXT/registry/
RUN python3 -m compileall $PYTHON_EXT/registry/*.py

ADD route.py secret_key ./

ENTRYPOINT ["python", "route.py"]
