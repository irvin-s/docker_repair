FROM continuumio/anaconda3:5.1.0

COPY . /usr/src/app
WORKDIR /usr/src/app/micro/a2c


# Install StarCraft II

RUN wget -q http://blzdistsc2-a.akamaihd.net/Linux/SC2.4.0.2.zip

RUN apt-get install unzip && \
    unzip -P iagreetotheeula -d ~ SC2.4.0.2.zip &&\
    rm SC2.4.0.2.zip

RUN wget -q https://github.com/deepmind/pysc2/releases/download/v1.2/mini_games.zip

RUN unzip -d ~/StarCraftII/Maps/ mini_games.zip &&\
    rm mini_games.zip

# Install dependencies

RUN pip install tensorflow==1.4 && \
    pip install git+git://github.com/reinforceio/tensorforce.git@195d848957fc5d7adf7a9a89c495c14e192d7d0b

RUN git clone https://github.com/vwxyzjn/sc2gym.git &&\
    cd sc2gym && \
    pip install -e . && \
    cd .. && \
    pip install gym==0.9.4 

# Run the program

CMD python lstm.py