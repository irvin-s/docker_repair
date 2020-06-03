FROM python:2.7.12
MAINTAINER Karl Newell <karlnewell@gmail.com>

RUN pip install dpkt PyNacl
COPY overflowd.py /overflowd/overflowd.py
WORKDIR /workdir
ENTRYPOINT ["/overflowd/overflowd.py"]
CMD ["-h"]
