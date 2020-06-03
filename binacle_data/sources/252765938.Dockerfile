FROM 5003/builder:full  
RUN apk add \--no-cache curl-dev && \  
apk add \--no-cache R R-dev && \  
Rscript -e 'chooseCRANmirror(ind = 33)' \  
-e 'install.packages(c("TTR", \  
"data.table", \  
"dplyr", \  
"anytime", \  
"lubridate", \  
"quantmod", \  
"jsonlite"))'

