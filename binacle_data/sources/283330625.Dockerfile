FROM ubuntu:xenial

# Prerequisites
RUN apt-get update && \
    apt-get install -y curl apt-transport-https apt-utils locales iputils-ping && \
    locale-gen "en_US.UTF-8"

ENV LANG="en_US.UTC-8" ACCEPT_EULA="Y"

# Microsoft SQL Server tools
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list
RUN apt-get update && \
    apt-get install -y mssql-tools unixodbc-dev && \
    ln -sfn /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd && \
    ln -sfn /opt/mssql-tools/bin/bcp /usr/bin/bcp

RUN apt-get remove -y curl apt-transport-https && \
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean

# T-SQL scripts to run
RUN mkdir -p /sql-scripts
WORKDIR /sql-scripts

COPY entrypoint.sh /usr/bin/entrypoint.sh

ENV SQL_DATABASE="master"

ENTRYPOINT [ "/bin/bash", "/usr/bin/entrypoint.sh" ]
