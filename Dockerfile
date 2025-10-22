# .devcontainer/Dockerfile
FROM ruby:3.3.0

# Install essential packages, PostgreSQL client libraries, and netcat
RUN apt-get update && apt-get install -y \
    nodejs \
    yarn \
    build-essential \
    libpq-dev \
    netcat-traditional \
 && rm -rf /var/lib/apt/lists/*

# Install Rails and Bundler
RUN gem install rails bundler

# Set working directory
WORKDIR /app

# copy Gemfile for bundler 
COPY Gemfile Gemfile.lock /app

RUN bundle install

EXPOSE 3000

# Set the entrypoint (no CMD here to auto-run Rails)
ENTRYPOINT ["bin/docker-entrypoint"]

