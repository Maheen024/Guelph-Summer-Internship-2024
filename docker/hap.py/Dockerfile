# Base image: Ubuntu 18.04
FROM ubuntu:18.04

# Set environment variable to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install required packages
RUN apt-get update && \
    apt-get install -y \
        autoconf \                  # Tool for generating configuration scripts
        build-essential \            # Essential tools for building software
        bzip2 \                      # Compression tool
        cmake \                      # Cross-platform build system
        cython \                     # Python-to-C compiler
        git \                        # Version control system
        libbz2-dev \                 # Development files for Bzip2
        libncurses5-dev \            # Development files for ncurses (terminal handling library)
        openjdk-8-jdk \              # Java Development Kit
        pkg-config \                 # Tool for managing library compile/link flags
        python \                     # Python interpreter
        python2.7 \                  # Python 2.7 interpreter
        python2.7-dev \              # Development files for Python 2.7
        python-setuptools \          # Python package management tool
        python-pip \                 # Python package installer
        python-psutil \              # Process and system utilities for Python
        python-numpy \               # Numerical computations in Python
        python-pandas \              # Data analysis library in Python
        python-distribute \          # Deprecated package distribution tool for Python
        python-pysam \               # Python interface for SAM/BAM sequence alignment files
        python-scipy \               # Scientific computation library in Python
        software-properties-common \ # Manage software repositories
        wget \                       # Command-line utility for downloading files
        zlib1g-dev && \              # Compression library
    apt-get clean -y                 # Clean up package cache

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
