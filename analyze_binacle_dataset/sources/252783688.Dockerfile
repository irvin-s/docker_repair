FROM degibenz/tornado-super  
MAINTAINER alexey shkil  
  
RUN mkdir -p /home/web/daf-razbor  
RUN useradd -m tornado  
  
ADD src /home/web/daf-razbor/src  
  
USER tornado  
WORKDIR /home/web/daf-razbor/src  
  
EXPOSE 8877  
CMD ["python", "main.py"]

