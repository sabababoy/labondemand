FROM ubuntu:22.04

COPY main.tf .

RUN apt-get update
RUN apt-get install -y unzip wget
RUN wget https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
RUN unzip terraform_1.7.5_linux_amd64.zip
RUN mv terraform /usr/local/bin/