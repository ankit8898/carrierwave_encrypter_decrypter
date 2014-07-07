module Openssl
  module Aes
    def self.encrypt_for(obj)
      begin
        model = obj.model
        mounted_as = obj.mounted_as
        cipher = OpenSSL::Cipher.new("AES-#{Carrierwave::EncrypterDecrypter.configuration.key_size}-CBC")
        cipher.encrypt
        iv = cipher.random_iv
        model.iv = iv
        key = cipher.random_key
        model.key = key
        model.save!

        original_file_path = File.expand_path(obj.store_path, obj.root)
        encrypted_file_path = File.expand_path(obj.store_path, obj.root) + ".enc"
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
        model = obj
        mounted_as = opts[:mounted_as]
        cipher = OpenSSL::Cipher.new("AES-#{Carrierwave::EncrypterDecrypter.configuration.key_size}-CBC")
        cipher.decrypt
        cipher.iv = model.iv
        cipher.key = model.key
        buf = ""

        original_file_path =  obj.send(mounted_as).root + obj.send(mounted_as).url
        encrypted_file_path =  obj.send(mounted_as).root + obj.send(mounted_as).url  + ".enc"

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
