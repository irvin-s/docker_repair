FROM microsoft/mssql-server-windows-express

ENV sa_password Password~2017
ENV ACCEPT_EULA Y

COPY import-json-files-to-tables.sql c:/import-json-files-to-tables.sql
COPY ww1.json c:/ww1.json
COPY ww2.json c:/ww2.json
COPY frenchrevolution.json c:/frenchrevolution.json
COPY renaissance.json c:/renaissance.json

RUN sqlcmd -i C:\import-json-files-to-tables.sql