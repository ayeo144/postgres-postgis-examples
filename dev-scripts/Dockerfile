#### Use latest Ubuntu
FROM ubuntu:focal

# Update base container install
RUN apt-get update

# Set the timezone to GB
ENV TZ 'GB'
RUN echo $TZ > /etc/timezone && \
    apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

# Install git
RUN apt-get install -y git
# Install GDAL dependencies
RUN apt-get install -y gcc libpq-dev python3 python3-pip libgdal-dev locales
RUN apt-get install -y gdal-bin

# Ensure locales configured correctly
RUN locale-gen en_GB.UTF-8
ENV LC_ALL='en_GB.utf8'

# Set python aliases for python3
RUN echo 'alias python=python3' >> ~/.bashrc
RUN echo 'alias pip=pip3' >> ~/.bashrc

# Update C env vars so compiler can find gdal
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

# Copy code from repo to image
RUN mkdir /code
COPY ./requirements.txt /code/requirements.txt 

RUN pip3 install -r /code/requirements.txt