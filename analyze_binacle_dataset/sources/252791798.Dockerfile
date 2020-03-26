FROM orientdb:2.2.4  
CMD ["/orientdb/bin/server.sh", "-Dnetwork.http.streaming=false"]

