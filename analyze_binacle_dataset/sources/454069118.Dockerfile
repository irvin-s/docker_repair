FROM alpine
COPY user /app/user
#ENTRYPOINT [ "/user-srv" ]
CMD ["/app/user"]