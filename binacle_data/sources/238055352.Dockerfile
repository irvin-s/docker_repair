FROM dltdojo/geth:1.6.6
RUN apk --update add tree
ADD build.sh info.sh start.sh ./
RUN chmod +x *.sh