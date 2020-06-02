ARG golang=chocolateyfest/golang
ARG target=mcr.microsoft.com/windows/nanoserver:1809

FROM $golang AS build

COPY . /code
WORKDIR /code

RUN go build http.go

FROM $target

COPY --from=build /code/http.exe /http.exe

EXPOSE 8080

CMD ["\\http.exe"]
