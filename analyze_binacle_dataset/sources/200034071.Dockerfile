FROM cookkkie/ffmpeg
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y libffi-dev
RUN apt-get install -y git
RUN apt-get install telnet -y
WORKDIR /
ADD requirements.txt /requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade -r requirements.txt
RUN python3 -m pip install -U https://github.com/cookkkie/discord.py/archive/async.zip#egg=discord.py[voice] 
ADD . /
CMD ["python", "bot.py"]
