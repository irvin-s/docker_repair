#To Build:     docker build --no-cache=true -t helloworldarm .

#To Run:		docker run --restart=always -d -t --env "WEBPAGESTRING=helloworld" -p 80:8080 --name helloworldarm -h helloworldarm helloworldarm

FROM scratch

MAINTAINER rnaylor@hivetechnologies.net

COPY ./helloworldlinuxarm .

EXPOSE 8080
CMD ["helloworldlinuxarm"]