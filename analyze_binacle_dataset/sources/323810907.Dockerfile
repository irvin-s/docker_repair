FROM jfloff/alscipy:3 as base 

RUN apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev

FROM base as build 
COPY requirements.txt /requirements.txt
RUN pip install --upgrade pip && pip install -r /requirements.txt
RUN python -m nltk.downloader wordnet punkt averaged_perceptron_tagger

FROM build
ENV PYTHONUNBUFFERED 1
COPY . /app
WORKDIR /app

EXPOSE 5687
#python run.py --topic ganja --num_slides 10 --output_folder=./ganja/ --open_ppt=false
ENTRYPOINT ["python"]
CMD ["run.py", "--topic", "indie music", "--num_slides", "10", "--output_folder", "/output", "--open_ppt", "false"]