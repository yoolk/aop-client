# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aop-client/version'

Gem::Specification.new do |spec|
  spec.name          = 'aop-client'
  spec.version       = AopClient::VERSION
  spec.authors       = ['Thaichor Seng']
  spec.email         = ['thaichor@gmail.com']

  spec.summary       = 'A lightweight, flexible library for Alibaba API and OAuth authentication.'
  spec.description   = 'Aop-Client is a lightweight, flexible ruby SDK for Alibaba. It allows full functionaliy of post product to Alibaba.'
  spec.homepage      = 'https://github.com/yoolk/aop-client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activemodel'
  spec.add_dependency 'typhoeus'
end