FROM python:2.7  
RUN git clone -b develop https://github.com/AHAAAAAAA/PokemonGo-Map.git  
  
WORKDIR /PokemonGo-Map  
  
RUN pip install --upgrade -r requirements.txt  
  
EXPOSE 5000  
ENTRYPOINT [ "python", "runserver.py" ]  
  

