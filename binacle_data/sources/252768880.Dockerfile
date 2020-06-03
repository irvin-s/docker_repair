FROM rocker/tidyverse  
LABEL maintainer="Andrew Heiss <andrew@andrewheiss.com>"  
  
# Install other libraries  
RUN install2.r --error \  
pander stargazer countrycode WDI \  
&& R -e "library(devtools); \  
install_github('slowkow/ggrepel')"  

