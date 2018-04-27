FROM ruby:2.5.1-alpine@sha256:f1dbca0f5dbc926eccc000967c6b09a441d1808f36b15fde4ae621124c2d3bb4

# Fetch/install gems
RUN mkdir -p /opt/gems
COPY Gemfile Gemfile.lock /opt/gems/
WORKDIR /opt/gems
RUN bundle install --deployment

ENV APP_DIR=/usr/src/app

COPY . $APP_DIR
RUN mkdir -p $APP_DIR/vendor && ln -s /opt/gems/vendor/bundle $APP_DIR/vendor/bundle

WORKDIR $APP_DIR
CMD ["./bin/run"]
