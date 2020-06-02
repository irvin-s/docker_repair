FROM centos:7
COPY highloadcup2018 /
EXPOSE 80
CMD ["/highloadcup2018"]
