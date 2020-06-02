FROM netm4ul/netm4ul
USER root
RUN apk add libpcap-dev git make build-base clang clang-dev linux-headers
RUN git clone --depth 1 https://github.com/robertdavidgraham/masscan.git /usr/src/masscan && cd /usr/src/masscan && make && make install && cd / && rm -rf /usr/src/masscan
USER netm4ul
WORKDIR /app
ENTRYPOINT ["./netm4ul"]
CMD ["version"]