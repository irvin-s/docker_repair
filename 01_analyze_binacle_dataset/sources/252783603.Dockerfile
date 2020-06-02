FROM deeplearninc/auger-ml-builder:experimental as builder  
  
FROM deeplearninc/auger-ml-worker-base:experimental  
  
LABEL vendor="DeepLearnInc"  
  
ENV WORKDIR=/var/src/auger-ml-worker  
  
WORKDIR $WORKDIR  
  
COPY \--from=builder /root/pip_packages /root/pip_packages  
COPY \--from=builder /root/.cache /root/.cache  
COPY \--from=builder /xgboost /xgboost  
COPY \--from=builder /requirements.txt $WORKDIR/  
  
RUN mkdir /usr/xgboost \  
&& mv /xgboost/lib/libxgboost.so /usr/xgboost  
  
RUN pip install --no-index --find-links=/root/pip_packages \  
/xgboost/python-package \  
-r $WORKDIR/requirements.txt  
  
COPY auger_ml $WORKDIR/auger_ml/auger_ml  
COPY setup.py $WORKDIR/auger_ml/setup.py  
COPY tests/*.py $WORKDIR/auger_ml/tests/  
COPY tests/fixtures $WORKDIR/auger_ml/tests/fixtures  
  
RUN mkdir $WORKDIR/auger_ml/tests/temp  
  
RUN pip install --no-index --find-links=/root/pip_packages $WORKDIR/auger_ml  
  
RUN rm -rf \  
/root/.cache \  
/root/pip_packages \  
/xgboost  

