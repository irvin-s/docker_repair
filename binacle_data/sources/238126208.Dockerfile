FROM alpine

ADD jwtd /bin/jwtd
ADD jwtd-ctl/jwtd-ctl /bin/jwtd-ctl

EXPOSE 80

CMD ["/bin/jwtd" ]
