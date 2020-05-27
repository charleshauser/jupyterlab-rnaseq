# Base Docker from: https://learning.cyverse.org/projects/Container-camp-2020/en/latest/docker/dockeradvanced.html
# fastqc Docker cimage: https://learning.cyverse.org/projects/cyverse-creating-docker-containers-quickstart/en/latest/step3.html

FROM jupyter/scipy-notebook:latest

# Add some metadata to describe our container
LABEL maintainer=""
LABEL maintainer_email="youremail"
LABEL version="1.0"




# reset user to root for installing additional packages
USER root

# copy configuration json and entry file into the container
# Placing jupyter config in /usr/src/app fixed permissions issues that occur if it is installed
# in /opt/conda/etc/jupyter/jupyter_notebook_config.json

COPY jupyter_notebook_config.json /usr/src/app
#COPY jupyter_notebook_config.json /opt/conda/etc/jupyter/jupyter_notebook_config.json
COPY entry.sh /bin



#########################
# Software: STAR Aligner
# Software Websit: https://github.com/alexdobin/STAR
COPY STAR /bin
COPY STARlong /bin


#########################
# Software: Trimmomatic
# trimmomatic-Docker https://github.com/chrishah/trimmomatic-docker/blob/master/Dockerfile
# Software Website: http://www.usadellab.org/cms/?page=trimmomatic
# SE: !trimmomatic SE -phred33 /home/work/data/small.fastq.gz /home/work/data/small.fq.gz ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
# PE: !trimmomatic PE -phred33 input_forward.fq.gz input_reverse.fq.gz output_forward_paired.fq.gz output_forward_unpaired.fq.gz output_reverse_paired.fq.gz output_reverse_unpaired.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36



# NEW: Add project files
# https://github.com/cyverse-vice/snakemake-vice/blob/master/Dockerfile
COPY environment.yml /home/jovyan/environment.yml


# Install a few dependencies for iCommands, text editing, and monitoring instances
RUN apt-get update && apt-get install -y \
      apt-transport-https \
      gcc \
      gnupg \
      htop \
      less \
      libfuse2 \
      libpq-dev \
      libssl1.0 \
      lsb \
      nano \
      nodejs \
      python-requests \
      software-properties-common \
      vim

# Install iCommands
RUN wget https://files.renci.org/pub/irods/releases/4.1.12/ubuntu14/irods-icommands-4.1.12-ubuntu14-x86_64.deb && \
dpkg -i irods-icommands-4.1.12-ubuntu14-x86_64.deb && \
rm irods-icommands-4.1.12-ubuntu14-x86_64.deb


####### new
# Install conda environment
# dependencies are included in environment.yml
RUN conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda env update -n base -f environment.yml && \
    conda clean --all

# reset container user to jovyan
USER jovyan

# set the work directory
WORKDIR /home/jovyan

# Open port for running Jupyter Notebook
# (Jupyter Notebook has to be separately installed in the container)
EXPOSE 8888

# directory will be populated by iCommands when entry.sh is run
RUN mkdir -p /home/jovyan/.irods

ENTRYPOINT ["bash", "/bin/entry.sh"]


