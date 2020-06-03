FROM berlius/artificial-intelligence-gpu

MAINTAINER berlius <berlius52@yahoo.com>

RUN pip install nltk

COPY install.sh /root
RUN chmod +x /root/install.sh
COPY sample_captions.txt /root/sample_captions.txt
COPY nltk_data.py /root
COPY sample_caption_vectors.hdf5 /root
COPY combined_image_0.jpg /root/ex_1.jpg
COPY combined_image_1.jpg /root/ex_2.jpg
COPY combined_image_2.jpg /root/ex_3.jpg

WORKDIR "/root"
CMD ["/bin/bash"]
