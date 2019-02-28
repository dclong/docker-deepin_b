FROM bestwu/deepin:panda

RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        sudo \
        wajig software-properties-common apt-transport-https \
        tzdata locales lsb-release \
        bash-completion command-not-found man-db \
        neovim git colordiff \
        gcc cmake \
        rsync wget curl proxychains \
        unzip bzip2 \
    && apt-get autoremove -y \
    && apt-get autoclean -y

# timezone
ARG TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

RUN locale-gen en_US.UTF-8 \
    && mkdir -p /workdir && chmod 777 /workdir
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8  

COPY scripts /scripts

ENTRYPOINT ["/scripts/init.sh"]
