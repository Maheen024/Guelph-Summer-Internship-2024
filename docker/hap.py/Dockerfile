# Base image: Ubuntu 18.04
FROM ubuntu:18.04

# Set environment variable to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install required packages
RUN apt-get update && \
    apt-get install -y \
        autoconf \                  
        build-essential \           
        bzip2 \                     
        cmake \                      
        cython \                    
        git \                      
        libbz2-dev \                 
        libncurses5-dev \           
        openjdk-8-jdk \              
        pkg-config \                
        python \                     
        python2.7 \                
        python2.7-dev \              
        python-setuptools \         
        python-pip \                
        python-psutil \             
        python-numpy \               
        python-pandas \              
        python-distribute \          
        python-pysam \              
        python-scipy \              
        software-properties-common \ 
        wget \                      
        zlib1g-dev && \              
    apt-get clean -y                

# Install additional Python package required by hap.py
RUN pip install bx-python

# Copy the contents of the current directory into the image (hap.py source code)
RUN mkdir -p /opt/hap.py-source
COPY . /opt/hap.py-source/

# Create directory for storing hap.py data
RUN mkdir -p /opt/hap.py-data

# Set the working directory where hap.py data will be stored
WORKDIR /opt/hap.py-data

# Download and install Apache Ant, a Java-based build tool needed for building hap.py
WORKDIR /opt
RUN wget http://archive.apache.org/dist/ant/binaries/apache-ant-1.9.7-bin.tar.gz && \
    tar xzf apache-ant-1.9.7-bin.tar.gz && \
    rm apache-ant-1.9.7-bin.tar.gz

# Add Apache Ant to the system PATH to make its commands accessible globally
ENV PATH $PATH:/opt/apache-ant-1.9.7/bin

# Set the working directory to where hap.py source code is located
WORKDIR /opt/hap.py-source

# Install hap.py with support for RTG tools, skipping tests since no reference file is provided
RUN python install.py /opt/hap.py --with-rtgtools --no-tests

# Set the working directory to the hap.py installation directory
WORKDIR /opt/hap.py

# Run basic tests to verify that hap.py has been installed and is functioning correctly
RUN bin/test_haplotypes

# Clean up the installation environment by removing the hap.py source directory
WORKDIR /
RUN rm -rf /opt/hap.py-source

# Set the default command to open a bash shell when the container starts
CMD ["/bin/bash"]
