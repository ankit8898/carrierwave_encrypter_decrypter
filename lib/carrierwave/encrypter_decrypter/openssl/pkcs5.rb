require 'yaml'
module Openssl
  module Pkcs5
    def self.encrypt_for(obj)
      begin
        config = YAML.load_file("#{Rails.root}/config/carrierwave_encrypter_decrypter.yml")[Rails.env]
        model = obj.model
        mounted_as = obj.mounted_as

        cipher = OpenSSL::Cipher.new("AES-#{Carrierwave::EncrypterDecrypter.configuration.key_size}-CBC")
        cipher.encrypt
        iv = cipher.random_iv
        model.iv = iv

        pwd = config['pkcs5_password']

        salt = OpenSSL::Random.random_bytes 16

        model.key = salt

        iter = 20000

        key_len = cipher.key_len
        digest = OpenSSL::Digest::SHA256.new

        key = OpenSSL::PKCS5.pbkdf2_hmac(pwd, salt, iter, key_len, digest)
        cipher.key = key

        original_file_path = File.expand_path(obj.store_path, obj.root)
        encrypted_file_path = File.expand_path(obj.store_path, obj.root) + ".enc"
        model.save!


        buf = ""
        File.open(encrypted_file_path, "wb") do |outf|
          File.open(model.send(mounted_as).path, "rb") do |inf|
            while inf.read(4096, buf)
              outf << cipher.update(buf)
            end
            outf << cipher.final
          end
        end
        File.unlink(model.send(mounted_as).path)
      rescue Exception => e
        puts "****************************#{e.message}"
        puts "****************************#{e.backtrace.inspect}"
      end
    end

    def self.decrypt_for(obj,opts)
      begin
        config = YAML.load_file("#{Rails.root}/config/carrierwave_encrypter_decrypter.yml")[Rails.env]
        model = obj
        mounted_as = opts[:mounted_as]

        cipher = OpenSSL::Cipher.new("AES-#{Carrierwave::EncrypterDecrypter.configuration.key_size}-CBC")
        cipher.decrypt
        cipher.iv = model.iv

        pwd = config['pkcs5_password']

        salt = model.key
        iter = 20000
        key_len = cipher.key_len
        digest = OpenSSL::Digest::SHA256.new

        key = OpenSSL::PKCS5.pbkdf2_hmac(pwd, salt, iter, key_len, digest)
        cipher.key = key

        original_file_path =  obj.send(mounted_as).root + obj.send(mounted_as).url
        encrypted_file_path =  obj.send(mounted_as).root + obj.send(mounted_as).url  + ".enc"

        buf = ""

        File.open(original_file_path, "wb") do |outf|
          File.open(encrypted_file_path, "rb") do |inf|
            while inf.read(4096, buf)
              outf << cipher.update(buf)
            end
            outf << cipher.final
          end
        end
      rescue Exception => e
        puts "****************************#{e.message}"
        puts "****************************#{e.backtrace.inspect}"
      end
    end
  end
end
