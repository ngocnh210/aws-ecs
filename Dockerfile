FROM jetbrains/teamcity-agent:latest
USER root
LABEL maintainer="Nguyen Hong Ngoc <me@ngocnh.info>"

ENV LD_LIBRARY_PATH /opt/oracle/instantclient_21_5:${LD_LIBRARY_PATH}
ENV ORACLE_HOME /opt/oracle/instantclient_21_5
ENV NODE_OPTIONS "--max-old-space-size=8192"

# Install Build Dependencies
RUN apt update  -y && apt upgrade -y

RUN apt install -y --no-install-recommends \
      build-essential \
      autoconf \
      make \
      gcc \
      musl-dev \
      g++ \
      libxml2-dev \
      imagemagick \
      libpq-dev \
      libpng-dev \
      libmcrypt-dev \
      libmemcached-dev \
      libzip-dev \
      curl \
      libjpeg-dev \
      libfreetype6-dev \
      libssl-dev \
      zlib1g-dev \
      libicu-dev \
      libc-client-dev \
      libkrb5-dev \
      libmagickwand-dev \
      libaio1 \
      unzip \
      ruby \
      ruby-dev \
      curl \
      zip \
      git \
      nano

# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt install -y nodejs && \
    npm install -g \
      gulp-cli eslint \
      @babel/eslint-parser \
      eslint-plugin-react \
      eslint-plugin-vue \
      yarn

# Installing PHP
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    php-cli php-bz2 php-soap php-curl php-mbstring php-pdo \
    php-gd php-xml php-zip zip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer