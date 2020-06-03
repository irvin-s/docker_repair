FROM golang:1.9 as builder  
  
LABEL maintainer "David Ndungu <dnjuguna@gmail.com>"  
  
WORKDIR /app  
  
COPY main.go .  
  
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .  
  
FROM scratch  
  
LABEL maintainer "David Ndungu <dndungu@zendesk>"  
  
WORKDIR /app  
  
COPY \--from=builder /app/app .  
  
COPY page.tpl .  
  
ENV BLANKPAGE_PORT 80  
EXPOSE ${BLANKPAGE_PORT}  
  
ENTRYPOINT ["/app/app"]  

