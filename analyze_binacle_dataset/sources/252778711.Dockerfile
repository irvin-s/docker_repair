FROM python:3.6-alpine  
  
MAINTAINER buckket <buckket@cock.li>  
  
RUN apk add --no-cache gcc python3-dev musl-dev postgresql-dev jpeg-dev git  

