FROM circleci/php:7.2
MAINTAINER senbazuru

RUN deps='\
         ruby \
         graphviz \
         nodejs \
         libpq-dev \
         libpng-dev \
         openjdk-8-jdk \
         ' \
    && set -x \
    && curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - \
    && sudo apt update -qq \
    && sudo apt install -y -qq --no-install-recommends $deps \
    && sudo rm -rf /var/lib/apt/lists/* \
    && sudo gem install bundler hub --no-document \
    && sudo docker-php-ext-install pdo_pgsql \
    && composer global require hirak/prestissimo

