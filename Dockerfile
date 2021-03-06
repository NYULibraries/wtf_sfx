FROM ruby:2.5-alpine

ENV RUN_PACKAGES bash ca-certificates fontconfig git mariadb-dev nodejs nodejs-npm tzdata
ENV BUILD_PACKAGES build-base curl-dev linux-headers ruby-dev wget
ENV FONTCONFIG_PATH /etc/fonts
# Env
ENV INSTALL_PATH /app
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin \
    GEM_HOME=/usr/local/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
ENV USER docker

RUN addgroup -g 2000 $USER && \
    adduser -D -h $INSTALL_PATH -u 1000 -G $USER $USER

WORKDIR $INSTALL_PATH

# Bundle install
COPY Gemfile Gemfile.lock ./
RUN apk add --no-cache $BUILD_PACKAGES $RUN_PACKAGES \
  && gem install bundler -v '2.0.1' \
  && bundle config --local github.https true \
  && bundle install --jobs 20 --retry 5 \
  && chown -R docker:docker $BUNDLE_PATH \
  && wget --no-check-certificate -q -O - https://github.com/dustinblackman/phantomized/releases/download/2.1.1a/dockerized-phantomjs.tar.gz | tar xz -C /  \
  && npm config set user 0 \
  && npm install -g phantomjs-prebuilt \
&& apk del $BUILD_PACKAGES
USER $USER

COPY --chown=docker:docker . .

CMD ["bundle", "exec", "rake"]
