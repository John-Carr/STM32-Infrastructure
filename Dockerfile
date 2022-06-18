FROM ubuntu:20.04

ENV STM32CUBEIDE_VERSION=1.8.0

ENV DEBIAN_FRONTEND=noninteractive

ENV LICENSE_ALREADY_ACCEPTED=1

ENV TZ=Etc/UTC

ENV PATH="${PATH}:/opt/st/stm32cubeide_${STM32CUBEIDE_VERSION}"

# STM Cube IDE Build Number
ARG BUILD="11526_20211125_0815"

RUN apt-get -y update && \
	apt-get -y install zip curl

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    apt-get install -y git-lfs

RUN git clone https://github.com/John-Carr/STM32-Infrastructure.git

RUN ls -la

RUN ls -la STM32-Infrastructure

RUN head -10 ./st-stm32cubeide_${STM32CUBEIDE_VERSION}_${BUILD}_amd64.deb_bundle.sh

RUN git lfs pull

RUN head -10 ./st-stm32cubeide_${STM32CUBEIDE_VERSION}_${BUILD}_amd64.deb_bundle.sh

RUN chmod +x ./st-stm32cubeide_${STM32CUBEIDE_VERSION}_${BUILD}_amd64.deb_bundle.sh \
    && ./st-stm32cubeide_${STM32CUBEIDE_VERSION}_${BUILD}_amd64.deb_bundle.sh \
    && rm ./st-stm32cubeide_${STM32CUBEIDE_VERSION}_${BUILD}_amd64.deb_bundle.sh

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
