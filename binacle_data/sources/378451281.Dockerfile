FROM progrium/busybox
ADD ./run.sh /tmp/run.sh
CMD ["/tmp/run.sh"]