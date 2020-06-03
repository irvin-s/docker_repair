FROM continuumio/miniconda  
  
RUN apt-get update && \  
apt-get install -y git samtools  
  
# added pooling report script  
ADD ./bam2junc.sh ./bed2junc.pl ./filter_cs.py ./sam2bed.pl ./  
  
CMD sh  

