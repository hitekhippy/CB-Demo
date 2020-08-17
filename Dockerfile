FROM jenkins/jenkins:lts
# if we want to install via apt
USER root
RUN apt-get update && wget https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip && unzip ./terraform_0.12.29_linux_amd64.zip -d /usr/local/bin
# drop back to the regular jenkins user - good practice
USER jenkins