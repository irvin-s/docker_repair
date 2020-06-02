FROM deeplearninc/basepython  
  
LABEL vendor="DeepLearnInc"  
  
ENV WORKDIR=/var/src/auger_notebook  
ENV PROJDIR=$WORKDIR  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \  
install_packages nodejs  
  
WORKDIR $WORKDIR  
COPY . $WORKDIR  
  
# Prepare static assets before python install  
RUN rm -rf node_modules && \  
npm install && \  
npm run build-dev && \  
python setup.py install && \  
pip install --no-cache-dir -r requirements.txt && \  
jupyter nbextension install --py auger_notebook && \  
jupyter nbextension enable \--py auger_notebook && \  
jupyter serverextension enable \--py auger_notebook && \  
jupyter nbextension install --py widgetsnbextension && \  
jupyter nbextension enable \--py widgetsnbextension && \  
jupyter nbextension install --py fileupload && \  
jupyter nbextension enable \--py fileupload && \  
python $PROJDIR/link_css.py && \  
rm -rf node_modules ~/.npm ~/.cache  
  
CMD ./bin/setup-files && ./bin/run-notebook  

