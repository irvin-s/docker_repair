FROM scratch
ADD dist/ipservice /opt/bin/
ADD data/17monipdb.dat /opt/bin/
CMD ["/opt/bin/ipservice", "-data", "/opt/bin/17monipdb.dat"]
