FROM ruby:2.4.5-alpine

RUN apk add --update udev ttf-freefont chromium chromium-chromedriver git libc-dev build-base libffi-dev \
 && git clone https://github.com/ishibashi-futos/ruby-selenium-apa.git && cd /ruby-selenium-apa \
 && bundle install --path vendor/bundler
