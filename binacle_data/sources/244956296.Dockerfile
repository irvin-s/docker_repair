FROM quay.io/coreos/etcd
COPY boot.sh .
EXPOSE 2379 2380
CMD ["./boot.sh"]
