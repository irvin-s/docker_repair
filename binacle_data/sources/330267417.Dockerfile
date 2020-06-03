FROM netm4ul/netm4ul
USER root
RUN apk add --update nmap
USER netm4ul
WORKDIR /app
ENTRYPOINT ["./netm4ul"]
CMD ["version"]