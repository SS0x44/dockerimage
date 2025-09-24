FROM amazonlinux:latest
ENV MVN_VERSION=3.9.6
ENV TERRAFORM_VERSION=1.13.3
ENV TERRAGRUNT_VERSION=0.87.0
ENV GRADLE_VERSION=8.4
ENV GO_VERSION=1.22.2
# Install system packages
RUN yum update -y && yum install -y wget git zip unzip tar jq python3 python3-pip gcc make curl yum-utils shadow-utils java-17-amazon-corretto-devel
# Install boto3
RUN pip3 install boto3
# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto
ENV PATH=$JAVA_HOME/bin:$PATH
# Install Maven 3.9.6
RUN wget https://downloads.apache.org/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz && \
    tar -xzf apache-maven-${MVN_VERSION}-bin.tar.gz -C /opt && \
    ln -s /opt/apache-maven-${MVN_VERSION} /opt/maven && \
    rm apache-maven-${MVN_VERSION}-bin.tar.gz
ENV M2_HOME=/opt/maven
ENV PATH=$M2_HOME/bin:$PATH

# Install Terraform 1.13.3
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
# Install Terragrunt v0.87.0
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 && \
    chmod +x terragrunt_linux_amd64 && \
    mv terragrunt_linux_amd64 /usr/local/bin/terragrunt
# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip -d /opt && \
    ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle && \
    rm gradle-${GRADLE_VERSION}-bin.zip
ENV GRADLE_HOME=/opt/gradle
ENV PATH=$GRADLE_HOME/bin:$PATH
# Install Go
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm go${GO_VERSION}.linux-amd64.tar.gz
ENV GOROOT=/usr/local/go
ENV GOPATH=/go
ENV PATH=$GOROOT/bin:$GOPATH/bin:$PATH
# Default shell
CMD ["/bin/bash"]
