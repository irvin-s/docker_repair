FROM jekyll/builder:pages  
MAINTAINER Danny Edel <mail@danny-edel.de>  
  
# Adds a C compiler and make, and the headers for ruby  
RUN apk --update add alpine-sdk ruby-dev  
  
# Add extra: jekyll-responsive_images, which requires imagemagick-dev  
RUN apk --update add imagemagick-dev  
RUN gem install --no-document --verbose jekyll-responsive_image  

