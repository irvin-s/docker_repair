FROM bblfsh/php-driver-build

ADD build /opt/driver
ENTRYPOINT ["/opt/driver/bin/driver"]
