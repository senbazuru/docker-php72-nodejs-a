FROM circleci/php:7.2
MAINTAINER senbazuru

RUN deps='\
         ruby \
         graphviz \
         nodejs \
         yarn \
         libpq-dev \
         libpng-dev \
         openjdk-8-jdk \
         ' \
    && set -x \
    && curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    && sudo apt update -qq \
    && sudo apt install -y -qq --no-install-recommends $deps \
    && sudo rm -rf /var/lib/apt/lists/* \
    && sudo gem install bundler hub --no-document \
    && sudo docker-php-ext-install exif gd pdo_pgsql \
    && composer global require hirak/prestissimo
