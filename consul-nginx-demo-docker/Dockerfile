FROM nginx
MAINTAINER Fábio Tramasoli <fabio@tramasoli.com>
LABEL env=des
RUN apt-get update \
    && apt-get install -y unzip wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* \
    && cd /usr/local/bin \
    && wget https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_amd64.zip \
    && unzip consul*zip \
    && rm consul*zip \
    && mkdir -p /consul-template/data \
    && mkdir -p /consul-template/config

RUN echo "nginx & " > /bootstrap.sh
RUN echo "/usr/local/bin/consul-template -config=/consul-template/config " >> /bootstrap.sh
VOLUME /consul-template/
EXPOSE 8500 8080
CMD ["/bin/bash","/bootstrap.sh"]
