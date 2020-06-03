FROM scratch
ADD ./sapin /sapin
ENTRYPOINT ["/sapin"]
