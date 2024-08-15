### IMPORTANT NOTE:
###
### This Dockerfile builds the Docker image for the MadMiner "heavy-weight" environment.
### The "heavy-weight" environment provides a working installation of MadGraph 5
### and all the necessary sub-dependencies to run Physics dependent steps:
### - pythia8
### - Delphes
###
### Please consider, that even if this Dockerfile definition is extremely similar as the one
### used for the "madminer-workflow-ph" Docker image, it is better not to depend on it,
### given that the common sections between the two will be moved to a MadMiner provided
### "heavy" version image soon enough.
###
### Check: https://github.com/madminer-tool/madminer/issues/421


#### Base image
#### Reference: https://github.com/root-project/root-docker/blob/master/ubuntu/Dockerfile
FROM rootproject/root:6.24.00-ubuntu20.04


#### Install binary dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        wget \
        rsync \
        gfortran \
        build-essential \
        ca-certificates \
        libboost-all-dev \
        python3-pip


#### Define working folders
ENV PROJECT_FOLDER "/madminer"
ENV SOFTWARE_FOLDER "/madminer/software"


#### MadGraph 5 environment variables
ENV MG_VERSION "MG5_aMC_v2.9.16"
ENV MG_FOLDER "MG5_aMC_v2_9_16"
ENV MG_FOLDER_PATH "${SOFTWARE_FOLDER}/${MG_FOLDER}"
ENV MG_BINARY_PATH "${SOFTWARE_FOLDER}/${MG_FOLDER}/bin/mg5_aMC"

#### CERN ROOT environment variables
ENV PATH $PATH:$ROOTSYS/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$ROOTSYS/lib


### Install MadGraph 5 Python dependencies
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir six==1.15.0

#### Install MadGraph 5
RUN mkdir -p ${SOFTWARE_FOLDER} && true \
    | curl -sSL "https://launchpad.net/mg5amcnlo/lts/2.9.x/+download/${MG_VERSION}.tar.gz" \
    | tar -xz -C ${SOFTWARE_FOLDER}


#### Install Pythia8 and Delphes
RUN echo "n" | python3 ${MG_BINARY_PATH}
RUN echo "install pythia8" | python3 ${MG_BINARY_PATH}
RUN grep '^pythia8_path =' ${MG_FOLDER_PATH}/input/mg5_configuration.txt
RUN grep '^mg5amc_py8_interface_path =' ${MG_FOLDER_PATH}/input/mg5_configuration.txt
RUN grep '^lhapdf_py3 =' ${MG_FOLDER_PATH}/input/mg5_configuration.txt
RUN echo "install Delphes" | python3 ${MG_BINARY_PATH}
RUN command -v ${MG_FOLDER_PATH}/Delphes/DelphesHepMC3

# Turn ON Python2 -> Python3 models conversion
RUN echo "set auto_convert_model T" | python3 ${MG_BINARY_PATH}
RUN echo "import model EWdim6-full" | python3 ${MG_BINARY_PATH}

# Delphes environment variables
ENV ROOT_INCLUDE_PATH "${ROOT_INCLUDE_PATH}:${MG_FOLDER_PATH}/Delphes/external"


#### Copy files
COPY requirements.txt ${PROJECT_FOLDER}/

# Install Python3 dependencies
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir --requirement ${PROJECT_FOLDER}/requirements.txt


#### Set working directory
WORKDIR ${PROJECT_FOLDER}
