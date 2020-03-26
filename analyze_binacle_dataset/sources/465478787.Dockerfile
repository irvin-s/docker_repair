FROM elementaryrobotics/atom

# Add in the python file
ADD main.py /code/main.py

# And set the default command to run the python file
WORKDIR /code
CMD ["python3", "main.py"]
