FROM alpine
ADD movie-srv /movie-srv
ENTRYPOINT [ "/movie-srv" ]
