# ----------------------------------------------------------------------
# Numenta Platform for Intelligent Computing (NuPIC)
# Copyright (C) 2017, Numenta, Inc.  Unless you have an agreement
# with Numenta, Inc., for a separate license for this software code, the
# following terms and conditions apply:
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero Public License version 3 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Affero Public License for more details.
#
# You should have received a copy of the GNU Affero Public License
# along with this program.  If not, see http://www.gnu.org/licenses.
#
# http://numenta.org/licenses/
# ----------------------------------------------------------------------
FROM python:2.7

# install requirements
COPY requirements.txt /nta/nupic.vision/requirements.txt
RUN pip install -r /nta/nupic.vision/requirements.txt

# Set up MNIST data
COPY src/nupic/vision/mnist /nta/nupic.vision/src/nupic/vision/mnist
WORKDIR /nta/nupic.vision/src/nupic/vision/mnist
RUN ./extract_mnist.sh
RUN mkdir -p /nta/nupic.vision/data/mnist \
    && mv mnist_extraction_source/training /nta/nupic.vision/data/mnist/ \
    && mv mnist_extraction_source/testing /nta/nupic.vision/data/mnist/ \
    && python ./convertImages.py /nta/nupic.vision/data/mnist \
    && ./create_training_sample.sh /nta/nupic.vision/data/mnist

# Install nupic.vision
COPY . /nta/nupic.vision/
WORKDIR /nta/nupic.vision
RUN pip install -e .

# Run the experiment
WORKDIR /nta/nupic.vision
CMD ["python", "src/nupic/vision/mnist/run_mnist_experiment.py", "--data-dir", "data/mnist"]
