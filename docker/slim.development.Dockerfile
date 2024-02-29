ARG RUBY_VERSION
FROM ruby:${RUBY_VERSION:-3.1.2-slim}

ENV NLS_LANG=pt_BR.UTF-8
ENV BUNDLE_RETRY=3 \
    BUNDLE_PATH='/usr/local/bundle/gems' \
    NODE_ENV='development'

# Libs basicas
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    curl gnupg2 vim tzdata gcc g++ make zip libjemalloc-dev unzip

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so
# Adiciona para trabalhar com processamento de imagens

# Node e Yarn
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -\
  && apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
    wget libffi-dev ruby-dev libvips42 libvips ruby-vips\
  && apt-get upgrade -qq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*\
  && npm install -g yarn@1
################################################################

# Sqlite3
#
################################################################
# PostgreSql
RUN apt-get update -qq && apt-get install libpq-dev -qq 
################################################################

# Oracle
# ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_21_4
# ENV ORACLE_HOME=/opt/oracle/instantclient_21_4

# Configuração Client oracle para conexão de banco de dados oracle
# RUN apt-get update -qq  && apt-get install libaio1 -qq
# RUN wget https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-sdk-linux.x64-21.4.0.0.0dbru.zip && \
#     wget https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-sqlplus-linux.x64-21.4.0.0.0dbru.zip && \
#     wget https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-basic-linux.x64-21.4.0.0.0dbru.zip && \
#     mkdir -p /opt/oracle && \
#     cp instantclient-* /opt/oracle/ && \
#     cd /opt/oracle/ && \ 
#     unzip instantclient-basic-linux.x64-21.4.0.0.0dbru.zip && \
#     unzip instantclient-sdk-linux.x64-21.4.0.0.0dbru.zip && \
#     unzip instantclient-sqlplus-linux.x64-21.4.0.0.0dbru.zip && \
#     rm -rf /var/lib/apt/lists/* instantclient-basic-linux.x64-21.4.0.0.0dbru.zip instantclient-sdk-linux.x64-21.4.0.0.0dbru.zip instantclient-sqlplus-linux.x64-21.4.0.0.0dbru.zip && \
#     apt -y clean && \
#     apt -y remove wget unzip zip && \
#     apt -y autoremove && \
#     rm -rf /var/cache/apt

################################################################
RUN apt-get remove  -qq zip unzip


RUN MALLOC_CONF=stats_print:true ruby -e "exit"


WORKDIR /workspace/web

COPY web/Gemfile /workspace/web/Gemfile
COPY web/Gemfile.lock /workspace/web/Gemfile.lock
COPY web/package.json /workspace/web/package.json
COPY web/yarn.lock /workspace/web/yarn.lock
COPY docker/entrypoint.sh /entrypoint.sh
COPY web/ /workspace/web/


# RUN bundler binstubs debug bundler

################################################################

# Gem para envio de emails (Mailcatcher,  htmlbeautifier) 
# RUN gem install mailcatcher htmlbeautifier
################################################################

RUN ["chmod", "+x", "/entrypoint.sh"]

# RUN adduser --disabled-password app-user  
# USER app-user

RUN gem install bundler:${BUNDLER_VERSION:-2.2.21} \   
   && bundle install  --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1`  \
   && rm -rf $GEM_HOME/cache/* \
   && yarn --check-files --silent --cache-folder .yarn-cache && yarn cache clean

RUN SECRET_KEY_BASE=assets bundle exec rails assets:precompile
RUN SECRET_KEY_BASE=assets bundle exec rails javascript:build
RUN SECRET_KEY_BASE=assets bundle exec rails css:build

SHELL ["/bin/bash", "-o", "pipefail", "-c"]