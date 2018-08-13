FROM ruby:2.5.1

# Essential dependencies
RUN apt-get update -qq && apt-get install -y \
      bzip2 \
      wget

# PhantomJS
ENV PHANTOMJS_VERSION 2.1.1

RUN wget --no-check-certificate -q -O - https://cnpmjs.org/mirrors/phantomjs/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 | tar xjC /opt
RUN ln -s /opt/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle check || bundle install --jobs 20 --retry 5

COPY . .

CMD ["bundle", "exec", "rake"]
