# Build stage
FROM golang:1.21.5-alpine AS builder

RUN apk update && apk upgrade && apk add --no-cache curl

# Install tfsec
ENV GO111MODULE=on
RUN go install github.com/aquasecurity/tfsec/cmd/tfsec@latest

# Install TFLint
RUN wget -O /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v0.48.0/tflint_linux_amd64.zip && \
    unzip /tmp/tflint.zip -d /tmp && \
    install -v /tmp/tflint /bin && \
    rm /tmp/tflint.zip /tmp/tflint

# Install Terragrunt
RUN wget -O /bin/terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/v0.46.1/terragrunt_linux_amd64 && \
    chmod +x /bin/terragrunt

# Install Regula
RUN wget -O /tmp/regula.tar.gz https://github.com/fugue/regula/releases/download/v3.2.1/regula_3.2.1_Linux_x86_64.tar.gz && \
    tar -xvf /tmp/regula.tar.gz && \
    rm /tmp/regula.tar.gz && \
    mv regula /bin

# Install Infracost
RUN curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /bin/kubectl


# Final stage
FROM ghcr.io/runatlantis/atlantis:v0.27.0

USER root

RUN apk update && apk upgrade && \
    apk add --no-cache jq gcc musl-dev libffi-dev openssl-dev curl python3 py3-pip aws-cli && \
    ln -sf python3 /usr/bin/python && rm -rf /var/cache/apk/* /tmp/*

USER atlantis
COPY requirements.txt /home/atlantis/
RUN python3 -m venv /home/atlantis/.venv && \
    source /home/atlantis/.venv/bin/activate && \
    pip install --upgrade setuptools -q && pip install -U -q checkov && \
    pip install -r /home/atlantis/requirements.txt && \
    deactivate
## Install Epam Custodian
COPY c7n*.zip /c7n/
RUN [ ! -d /c7n ] \
 || (source /home/atlantis/.venv/bin/activate \
 && pip install /c7n/c7n*.zip \
 && rm -rf /c7n /var/cache/apk/* /tmp/* \
 && deactivate)

COPY --from=builder /go/bin/tfsec /usr/local/bin
COPY --from=builder /bin/tflint /usr/local/bin/tflint
COPY --from=builder /bin/regula /usr/local/bin/regula
COPY --from=builder /bin/terragrunt /usr/local/bin/terragrunt
COPY --from=builder /usr/local/bin/infracost /usr/local/bin/infracost
COPY --from=builder /bin/kubectl /usr/local/bin/kubectl