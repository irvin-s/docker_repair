# docker_repair
 Script's for automated Dockerfiles repair

 ## Usage / Setup
To use the automatic Dockerfiles repair, use Linux, and install the following requirements.

- Latest version of `Docker`
- Latest version of `Python3`
- Latest vervion of `Python3 pip`
- Latest version of `Linux OS`

### 1. Build Dockerfiles

- Before executing the building, insert the Dockerfiles in:
    `image_list.txt`

- To select what Dockerfiles to build see:
    `notes/sizesortedlist-dockerfiles.txt`
    - The filename must have this format `sources/228568839.Dockerfile`

- To build Dockerfiles run the script:
    `./build_test.sh`

- After run the script see Logs at:
    `logs/`
    - Logs for build failure `logs/fail`, and success `logs/success`

### 2. Generate Keywords from logs

- Before using the scripts install the requirements located in the `02_automated_keyword_generator/requirements.txt`
    - To install run this: `pip3 install -r requirements.txt`

- To automatic verify the failed logs run python script located at `02_automated_keyword_generator/`

- Run the python script using the following syntax:
    `python3 query_process.py ../logs/fail/228568839.log`

- Check the created keyword and the URLs for a possible repair at: `results/analyzed_query.json`

### 3. Proccess the keywords

 ## Pre-results

This repository work is in-flux, at this time there are only a few pre-results. The dataset of Dockerfiles must be in Context to avoid misconfiguration errors.
We are using TF-IDF to generate the keywords, first, we tried to use the RAKE algorithm, but we can't get good results.