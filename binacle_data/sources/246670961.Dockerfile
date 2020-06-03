FROM golang:1.11
ADD mkupspinserver.sh /mkupspinserver.sh
ENTRYPOINT ["/mkupspinserver.sh"]
