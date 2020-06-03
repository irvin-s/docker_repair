FROM golang:1.6-alpine  
MAINTAINER Danniel Magno <dennyloko@gmail.com>  
  
ADD ./ /go/src/github.com/DennyLoko/pokemongonobr  
WORKDIR /go/src/github.com/DennyLoko/pokemongonobr  
  
RUN go install  
  
CMD [ "pokemongonobr" ]  

