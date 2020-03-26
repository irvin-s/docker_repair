FROM pixeldothorse/core
# runner image
FROM xena/alpine
COPY --from=0 /root/go/src/github.com/pixeldothorse/pixeldothorse/bin/ /usr/local/bin/
CMD /usr/local/bin/pixeldothorsed
