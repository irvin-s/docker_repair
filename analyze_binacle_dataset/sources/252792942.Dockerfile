FROM danielquinn/django:debian  
  
MAINTAINER Daniel Quinn <code@danielquinn.org>  
  
RUN apt-get update \  
&& apt-get install -y \  
tesseract-ocr \  
tesseract-ocr-afr \  
tesseract-ocr-ara \  
tesseract-ocr-aze \  
tesseract-ocr-bel \  
tesseract-ocr-ben \  
tesseract-ocr-bul \  
tesseract-ocr-cat \  
tesseract-ocr-ces \  
tesseract-ocr-chi-sim \  
tesseract-ocr-chi-tra \  
tesseract-ocr-dan \  
tesseract-ocr-deu \  
tesseract-ocr-ell \  
tesseract-ocr-eng \  
tesseract-ocr-epo \  
tesseract-ocr-est \  
tesseract-ocr-eus \  
tesseract-ocr-fin \  
tesseract-ocr-fra \  
tesseract-ocr-glg \  
tesseract-ocr-heb \  
tesseract-ocr-hin \  
tesseract-ocr-hrv \  
tesseract-ocr-hun \  
tesseract-ocr-ind \  
tesseract-ocr-isl \  
tesseract-ocr-ita \  
tesseract-ocr-jpn \  
tesseract-ocr-kan \  
tesseract-ocr-kor \  
tesseract-ocr-lav \  
tesseract-ocr-lit \  
tesseract-ocr-mal \  
tesseract-ocr-mkd \  
tesseract-ocr-mlt \  
tesseract-ocr-msa \  
tesseract-ocr-nld \  
tesseract-ocr-nor \  
tesseract-ocr-pol \  
tesseract-ocr-por \  
tesseract-ocr-ron \  
tesseract-ocr-rus \  
tesseract-ocr-slk \  
tesseract-ocr-slv \  
tesseract-ocr-spa \  
tesseract-ocr-sqi \  
tesseract-ocr-srp \  
tesseract-ocr-swa \  
tesseract-ocr-swe \  
tesseract-ocr-tam \  
tesseract-ocr-tel \  
tesseract-ocr-tgl \  
tesseract-ocr-tha \  
tesseract-ocr-tur \  
tesseract-ocr-ukr \  
tesseract-ocr-vie \  
ghostscript \  
unpaper \  
&& apt-get autoremove -y \  
&& apt-get clean  
  
COPY requirements.txt /  
  
RUN pip install --requirement /requirements.txt  
  
EXPOSE 8000  
  
ENTRYPOINT /app/scripts/docker-production.entrypoint  

