FROM tjakobsson/sysbench

COPY /run.sh /scripts/run.sh
CMD ["/bin/bash", "/scripts/run.sh"]
