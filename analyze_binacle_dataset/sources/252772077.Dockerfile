FROM scratch  
MAINTAINER Pete McWilliams <pmcwilliams@augustash.com>  
  
# data-only containers don't need to stay running  
COPY defaults/true-asm /true  
CMD [ "/true" ]  

