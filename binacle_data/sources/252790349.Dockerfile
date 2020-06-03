FROM frolvlad/alpine-python3  
MAINTAINER ponteineptique <thibault.clerice[@]uni-leipzig.de>  
  
# Install required packages  
RUN apk add --no-cache git bash && pip install cookiecutter  
  
# Sets up locales to avoid decode issue in python  
ENV LANG C.UTF-8  
ADD guideline-maker /usr/bin/guidelines  
RUN chmod +x /usr/bin/guidelines  
  
WORKDIR /code/  
VOLUME /code/  
  
CMD ["guidelines"]

