$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "carrierwave/encrypter_decrypter/version"

Gem::Specification.new do |s|
  s.name        = 'carrierwave_encrypter_decrypter'
  s.version     = CarrierwaveEncrypterDecrypter::VERSION
  s.date        = '2013-12-31'
  s.summary     = "Secure the files that you upload with carrierwave"
  s.description = "A library for encrypting and decrypting uploaded files.  Supports Ruby OpenSSL::Cipher and OpenSSL::PKCS5 Strategies."
  s.authors     = ["Ankit gupta"]
  s.email       = 'ankit.gupta8898@gmail.com'
  s.files       = `git ls-files -- lib/*`.split("\n")
  s.files       += %w[Readme.md]
  s.require_paths = ["lib"]
  s.licenses    = ['MIT']
  s.rubygems_version = "2.0.6"
  s.homepage    =
    'https://github.com/ankit8898/carrierwave_encrypter_decrypter'

  s.add_runtime_dependency 'rails'
  s.add_runtime_dependency 'carrierwave'
end
