FROM jenkins/jenkins:lts
USER root
RUN apt-get update && wget -q https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip && \
    unzip ./terraform_0.12.29_linux_amd64.zip -d /usr/local/bin ;\
    apt-get install python3-pip -y ;\
    pip3 install c7n ; 
USER jenkins