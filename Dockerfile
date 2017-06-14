FROM ruby:2.4.1

RUN apt-get update && apt-get install -y \
        build-essential \
        libpq-dev \
        libxml2-dev \
        libxslt1-dev \
        nodejs \
        postgresql

ENV APP_HOME /webapp

ENV LANG C.UTF-8

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
RUN gem install bundler --no-ri --no-rdoc
RUN bundle install --jobs 20 --retry 5

# Copy the main application.
COPY ./config/database.yml $APP_HOME/config/database.yml

ADD docker-entrypoint.sh $APP_HOME/docker-entrypoint.sh
RUN chmod 775 $APP_HOME/docker-entrypoint.sh

EXPOSE 5000

ENTRYPOINT ["./docker-entrypoint.sh"]
