FROM mcr.microsoft.com/mssql/server:vNext-CTP2.0-ubuntu

COPY . /

RUN chmod +x /db-init.sh
CMD /bin/bash ./entrypoint.sh