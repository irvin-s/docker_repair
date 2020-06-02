FROM ubuntu:14.04
ADD get-versions /usr/bin/get-versions
RUN chmod +x /usr/bin/get-versions
ENTRYPOINT ["/usr/bin/get-versions"]
CMD ["bash"]
