FROM rocker/shiny

COPY app.R app.R

CMD ["R", "-e", "shiny::runApp('app.R', host='0.0.0.0', port=3838)"]
