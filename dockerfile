FROM ruby:2.5.1-slim
# Instala as nossas dependencias
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
  build-essential libpq-dev
# Seta nosso path
ENV INSTALL_PATH /onebitbot
# Cria nosso diretório
RUN mkdir -p $INSTALL_PATH
# Seta o nosso path como o diretório principal
WORKDIR $INSTALL_PATH
# Copia o nosso Gemfile para dentro do container
COPY Gemfile ./

#Atualiza o bundler
RUN gem install bundler -v 2.0.1
# Instala as Gems
RUN bundle install
RUN bundle update --bundler
# Copia nosso código para dentro do container
COPY . .
# Roda nosso servidor
CMD rackup config.ru -o 0.0.0.0