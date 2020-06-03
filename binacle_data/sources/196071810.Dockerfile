RUN wget http://msvocds.blob.core.windows.net/coco2014/train2014.zip && \
wget http://msvocds.blob.core.windows.net/coco2014/val2014.zip && \
#
# The annotations
wget http://msvocds.blob.core.windows.net/annotations-1-0-3/instances_train-val2014.zip && \
wget http://msvocds.blob.core.windows.net/annotations-1-0-3/person_keypoints_train+val5k2014.zip && \
wget http://msvocds.blob.core.windows.net/annotations-1-0-3/captions_train-val2014.zip && \