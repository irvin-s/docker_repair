FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y python-pip 
RUN apt-get install -y python-tk
RUN apt-get install -y graphviz
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
ADD requirements.txt /
RUN pip install Cython
RUN pip install -r requirements.txt
RUN echo 'export PYTHONPATH="${PYTHONPATH}:/pytlib"' >> ~/.bashrc 

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

