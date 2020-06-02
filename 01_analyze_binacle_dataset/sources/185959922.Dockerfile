FROM python:2.7.15-windowsservercore-1709

# Docker build context must be the the root of project (the folder with SickBeard.py)
COPY . /src/sickbeard
SHELL ["powershell.exe"]
WORKDIR C:\\src\\sickbeard
RUN Remove-Item -Recurse -Force C:\\src\\sickbeard\\docker\\data

RUN pip install --no-cache-dir -r .\\requirements.txt

VOLUME ["C:\\src\\sickbeard\\runtime", "C:\\tvshows", "C:\\downloads"]

CMD [ "python", ".\\SickBeard.py", "--config=C:\\src\\sickbeard\\runtime\\config.ini", "--datadir=C:\\src\\sickbeard\\runtime", "--addr=0.0.0.0", "--nolaunch"]