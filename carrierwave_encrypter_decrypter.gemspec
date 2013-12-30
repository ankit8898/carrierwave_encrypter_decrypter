$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "carrierwave/encrypter_decrypter/version"

Gem::Specification.new do |s|
  s.name        = 'carrierwave_encrypter_decrypter'
  s.version     = CarrierwaveEncrypterDecrypter::VERSION
  s.date        = '2013-12-29'
  s.summary     = "Secure the files that you upload with carrierwave"
  s.description = "A library supporting Ruby OpenSSL::Cipher and OpenSSL::PKCS5 for the file encryption and decryption"
  s.authors     = ["Ankit gupta"]
  s.email       = 'ankit.gupta8898@gmail.com'
  s.files       = [
                    "lib/carrierwave/encrypter_decrypter/encryption.rb",
                    "lib/carrierwave/encrypter_decrypter/uploader.rb",
                    "lib/carrierwave/encrypter_decrypter/downloader.rb",
                    "lib/carrierwave/encrypter_decrypter/configuration.rb",
                    "lib/carrierwave/encrypter_decrypter/version.rb",
                    "lib/carrierwave/encrypter_decrypter/openssl/aes.rb",
                    "lib/carrierwave_encrypter_decrypter.rb"]
  s.require_paths = ["lib"]
  s.licenses    = ['MIT']
  s.rubygems_version = "2.0.6"
  s.homepage    =
    'https://github.com/ankit8898/carrierwave_encrypter_decrypter'
  s.add_runtime_dependency 'logger'
  s.add_runtime_dependency 'rails'
  s.add_runtime_dependency 'carrierwave'
end