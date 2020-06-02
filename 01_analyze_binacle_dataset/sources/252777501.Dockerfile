FROM rocker/shiny  
  
LABEL maintainer="Andy Challis <andrewchallis@hotmail.co.uk>"  
RUN apt-get update && \  
apt-get install -y libav-tools curl && \  
apt-get install ffmpeg && \  
apt-get install -y python3-pip python3-dev && \  
pip3 install tensorflow pillow matplotlib  
  
RUN Rscript -e "install.packages('shinyWidgets')"  
#docker run --rm -p 3838:3838 \  
# -v ~/Documents/shinyapps/:/srv/shiny-server/ \  
# -v ~/Documents/shinylog/:/var/log/shiny-server/ \  
# shiny-obj  

