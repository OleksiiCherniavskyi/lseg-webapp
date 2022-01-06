FROM centos:latest
RUN yum -y install wget unzip && \
    wget https://get.helm.sh/helm-v3.7.2-linux-amd64.tar.gz && \
    tar -xvf helm-v3.7.2-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/bin/ &&  \
    chmod +x /usr/bin/helm && \
    rm -rf helm-v3.7.2-linux-amd64.tar.gz && \
    rm -rf linux-amd64

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install -i /usr/local/aws-cli -b /usr/local/bin && \
    ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

ADD helm-deploy.sh /usr/bin/
RUN chmod +x /usr/bin/helm-deploy.sh

CMD ["top"]

    

