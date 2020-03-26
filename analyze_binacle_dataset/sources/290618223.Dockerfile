FROM python:2.7.14-jessie

RUN mkdir -p /usr/src/mappr/athena
WORKDIR /usr/src/mappr/athena

COPY *.txt /usr/src/mappr/athena/

RUN pip install --no-cache-dir -r requirements.txt

COPY athena /usr/src/mappr/athena/athena

RUN cd athena/algorithms/NetworkAnalysis/ForceDirected && \
  make clean && make

COPY tests /usr/src/mappr/athena/tests
COPY *.conf /usr/src/mappr/athena/
COPY *.ini /usr/src/mappr/athena/
COPY *.py /usr/src/mappr/athena/
COPY *.sh /usr/src/mappr/athena/

CMD ["/bin/bash"]
