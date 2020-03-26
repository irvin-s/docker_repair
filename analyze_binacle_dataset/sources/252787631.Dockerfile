FROM python  
RUN pip install pydicom  
RUN pip install numpy  
COPY train.py /train.py  
COPY score_sc1.py /score_sc1.py  
COPY score_sc2.py /score_sc2.py  
COPY train.sh /train.sh  
COPY sc1_infer.sh /sc1_infer.sh  
COPY sc2_infer.sh /sc2_infer.sh  
COPY preprocess.sh /preprocess.sh  

