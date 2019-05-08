FROM ruby:2.3.7

# throw errors if Gemfile has been modified since Gemfile.lock
#RUN bundle config --global frozen 1

RUN apt-get update && apt-get install -y apt-utils nodejs mysql-client

WORKDIR /usr/src/app

#COPY Gemfile Gemfile.lock ./

#COPY . .
#RUN bundle install --path=vendor/bundle

#RUN chmod 700 server.sh && ls -l
#CMD ["./server.sh"]
#CMD ["/usr/local/bundle/bin/rails server"]
COPY server.sh /tmp/server.sh
RUN chmod 700 /tmp/server.sh

RUN ls -l /tmp

CMD ["/tmp/server.sh"]