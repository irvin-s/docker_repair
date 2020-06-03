FROM chryswoods/acquire-base:latest

# Need to be user root or Fn exits with
# {"message":"internal server error"}
USER root

WORKDIR $HOME
RUN mkdir $PYTHON_EXT/identity

ADD *.py $PYTHON_EXT/identity/
RUN python3 -m compileall $PYTHON_EXT/identity/*.py

ADD route.py secret_key ./

ENTRYPOINT ["python", "route.py"]
