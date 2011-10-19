# Normalize

Normalize your attributes with ease.

## Install

Add normalize to your `Gemfile` like this:

    gem 'normalize'

## Usage

Create a directory `app/normalizers` in your Rails project. This directory will
contain your normalizers. A normalizer is a class that responds to `call` with
the value that has to be normalized and returns the normalized value.

Example URL normalizer:

    class UrlNormalizer
      def self.call(input)
        url = input.dup
        url.prepend('http://') unless url =~ %r{^[a-zA-Z]+://}
        
        begin
          uri = URI.parse(url)
          uri.scheme = uri.scheme.downcase
          uri.host   = uri.host.downcase
        rescue
          return input
        end
        
        uri.to_s
      end
    end

Now in your ActiveRecord model, simply use the `normalize` method to normalize
input:

    class Website < ActiveRecord::Base
      normalize :url, with: UrlNormalizer
    end

## License

Copyright 2011 Tom-Eric Gerritsen.
You may use this work without restrictions, as long as this notice is included.
The work is provided "as is" without warranty of any kind, neither express nor implied.
