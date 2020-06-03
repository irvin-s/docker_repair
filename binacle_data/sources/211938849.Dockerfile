# Online scenario at katacoda.com/courses/docker/12

FROM busybox
COPY passwords.txt passwords.txt
RUN rm passwords.txt
CMD ["echo", "Done"]
