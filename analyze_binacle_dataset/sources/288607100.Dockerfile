FROM continuumio/anaconda3
RUN apt-get update
RUN apt-get install libgtk2.0-0 -y
RUN conda install -c menpo opencv3
RUN pip install tensorflow
ADD model.pb /code/model.pb
ADD standalone_inference_over_image.py /code/standalone_inference_over_image.py
ADD category_mapping.txt /code/category_mapping.txt
ADD script.sh /code/script.sh
RUN chmod +x /code/standalone_inference_over_image.py
RUN chmod +x /code/script.sh
