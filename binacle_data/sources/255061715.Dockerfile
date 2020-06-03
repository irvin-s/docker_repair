FROM frolvlad/alpine-python3

RUN pip3 install --upgrade pip
RUN pip3 install sphinx
RUN apk -U --no-cache add make git

COPY tools/ChatLexer /tmp
RUN cd /tmp && python3 setup.py install

RUN adduser -D cogdoc

USER cogdoc
WORKDIR /home/cogdoc
