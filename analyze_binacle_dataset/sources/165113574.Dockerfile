FROM microsoft/mssql-server-linux:2017-CU6

ENV ACCEPT_EULA y

ENV SA_PASSWORD PASSword123!@#

RUN ln -s /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd

RUN wget -q https://bootstrap.pypa.io/get-pip.py -O ~/get-pip.py && \
    python ~/get-pip.py && \
    pip install mssql-scripter

COPY ./schema /schema
