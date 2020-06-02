FROM chryswoods/acquire-base:latest

# Need to be user root or Fn exits with
# {"message":"internal server error"}
USER root

WORKDIR $HOME
RUN mkdir $PYTHON_EXT/compute

ADD *.py $PYTHON_EXT/compute/
RUN python3 -m compileall $PYTHON_EXT/compute/*.py

ADD route.py secret_key ./

ENTRYPOINT ["python", "route.py"]
