module Ced
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "This generator creates an initializer file at config/initializers"
      def create_initializer_file
        create_file "config/initializers/carrierwave_encrypter_decrypter.rb" do
          "Carrierwave::EncrypterDecrypter.configure  do |config|
    
    #This strategy is applicable when you planning for a AES Encrytion
    #Read more about it here http://ruby-doc.org/stdlib-2.0/libdoc/openssl/rdoc/OpenSSL.html#module-OpenSSL-label-Encryption
    config.encryption_type = :aes
    config.key_size = 256

    #This strategy is applicable when you want to have the pkcs5 (Password based encryption)
    #config.encryption_type = :pkcs5
    #config.key_size = 256
 end
"
        end
      end

      def copy_pkcs5_yml
        copy_file "carrierwave_encrypter_decrypter.yml","config/carrierwave_encrypter_decrypter.yml"
      end
    end
  end
end
