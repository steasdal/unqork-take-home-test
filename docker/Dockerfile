FROM ubuntu:18.04

ARG TERRAFORM_VERSION="1.1.7"
ARG AWSCLI_VERSION="2.4.5"

LABEL maintainer="Sam teasdale <samuel.teasdale@gmail.com>"
LABEL terraform_version=${TERRAFORM_VERSION}
LABEL aws_cli_version=${AWSCLI_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
ENV AWSCLI_VERSION=${AWSCLI_VERSION}
ENV TERRAFORM_VERSION=${TERRAFORM_VERSION}

# Install awscli
RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates software-properties-common unzip curl \
    && curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip -o "awscliv2.zip" \
    && unzip awscliv2.zip -d /temp \
    && /temp/aws/install \
    && rm awscliv2.zip

# Install ansible, kubectl, and git
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list \
    && add-apt-repository --yes --update ppa:ansible/ansible \
    && apt-get install -y ansible curl python2.7 python-pip python3 python3-pip python3-boto git kubectl \
    && ansible-galaxy collection install community.general --ignore-errors \
    && ansible-galaxy collection install kubernetes.core --ignore-errors

# Install the python kubernetes client which is required by the Ansible kubernetes.core.k8s module
RUN pip install kubernetes

# Install Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip '*.zip' -d /usr/local/bin \
    && rm *.zip 

# Tidy up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /temp

COPY ${PWD}/.aws /root/.aws

CMD    ["/bin/bash"]