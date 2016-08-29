#!/usr/bin/env bash

# base image
# https://hub.docker.com/r/phusion/baseimage/
FROM phusion/baseimage

# Export env settings
ENV LANG=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Export spark settings
ENV SPARK_HOME=/srv/spark
ENV PATH=${SPARK_HOME}/bin:$PATH
ENV PYSPARK_DRIVER_PYTHON=ipython
ENV PYTHONPATH=${SPARK_HOME}/python/:$PYTHONPATH
ENV PYTHONPATH=${SPARK_HOME}/python/lib/py4j-0.10.1-src.zip:$PYTHONPATH

# Install Java
RUN add-apt-repository --yes ppa:webupd8team/java
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get update \
    && apt-get install -y oracle-java8-installer

# Download and install spark
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-bin-hadoop2.7.tgz \
    && tar xvf spark-2.0.0-bin-hadoop2.7.tgz \
    && rm spark-2.0.0-bin-hadoop2.7.tgz \
    && mv spark-2.0.0-bin-hadoop2.7 /srv/spark

# Update the list of packages, upgrade the current packages and install build-essential
ADD /packages/image-packages.txt /tmp/image-packages.txt
RUN apt-get update \
    && apt-get -y build-dep libcurl4-gnutls-dev \
    && xargs -a /tmp/image-packages.txt apt-get install -y \
    && rm -rf /var/lib/apt/lists/*

# Clean apt-get
RUN apt-get clean \
    && apt-get autoremove

# Install python packages
ADD /packages/requirements/ /tmp/requirements
RUN pip --no-cache-dir install -r /tmp/requirements/requirements.txt

#setup R configs and install R packages
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'https://cloud.r-project.org/'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages(c('repr', 'IRdisplay', 'crayon', 'pbdZMQ', 'devtools'))"
RUN Rscript -e "install.packages(c('ggplot2', 'dplyr', 'reshape2', 'forecast', 'stringr'))"
RUN Rscript -e "install.packages(c('lubridate', 'randomForest', 'rpart', 'e1071', 'kknn'))"
RUN Rscript -e "devtools::install_github('IRkernel/IRkernel')"
RUN Rscript -e "IRkernel::installspec()"

# Install and enable vega for Altair
RUN jupyter nbextension install --py vega
RUN jupyter nbextension enable vega --py --sys-prefix

# Create new folders and set a workdir
RUN mkdir /home/datadocker
VOLUME /home/datadocker
WORKDIR /home/datadocker

# Add the running script
ADD /command/run.sh /root/run.sh
# Export port 8888
EXPOSE 8888

# Run jupyter
CMD ["/root/run.sh"]
