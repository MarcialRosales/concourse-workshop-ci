FROM golang:alpine

ENV TERRAFORM_VERSION=0.9.11
ENV TF_DEV=true
ENV CF_VERSION=dev
ENV TERRAFORM_SHA256SUM=804d31cfa5fee5c2b1bff7816b64f0e26b1d766ac347c67091adccc2626e16f3

RUN apk add --update git curl openssh make bash && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

WORKDIR $GOPATH/src/github.com/terraform-providers

RUN git clone https://github.com/mevansam/terraform-provider-cloudfoundry && \
    cd terraform-provider-cloudfoundry && \
    git fetch && \
    git checkout ${CF_VERSION} && \
    git branch && \
    make build && \
    echo $'providers {\n\  
      cf = "/usr/local/bin/terraform-provider-cloudfoundry"\n\
    }\n'\
    >> $HOME/.terraformrc && \
    cp ${GOPATH}/bin/terraform-provider-cloudfoundry /usr/local/bin && \ 
    rm -r $GOPATH


VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT []
