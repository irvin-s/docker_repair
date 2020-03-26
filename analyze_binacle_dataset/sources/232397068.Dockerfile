# a 5MB, no frills busybox based linux image that is great for starting with a "blank slate"
FROM alpine:latest

# write out a file by running a command
RUN echo "1st file with stuff" > first_file

# copy a local file into the image
#COPY second_file .

CMD echo "check out my files!" && ls -l && sleep 5 && echo "goodbye"