FROM rocker/r-base  
  
copy mlb-analytics-engine.R .  
  
CMD ["R", "mlb-analytics-engine.R"]

