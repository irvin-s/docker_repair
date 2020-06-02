FROM scratch

EXPOSE 8080
ADD ./main /main
ADD ./language /language
ADD ./dockerbuild /
CMD ["/main", "-server"]
