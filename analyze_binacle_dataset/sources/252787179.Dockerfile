FROM debian:jessie  
  
COPY ./proxysql_1.4.3-debian8_amd64.deb /tmp/  
  
ENV PROXYSQL_VERSION 1.4.3-1debian8  
  
EXPOSE 6032  
EXPOSE 6033  
VOLUME /var/lib/proxysql  
  
RUN build_deps='libssl1.0.0' \  
&& apt-get update \  
&& apt-get -y --force-yes install $build_deps \  
&& dpkg -i /tmp/proxysql_1.4.3-debian8_amd64.deb \  
&& apt-get clean  
  
ENTRYPOINT ["proxysql", "-f"]

