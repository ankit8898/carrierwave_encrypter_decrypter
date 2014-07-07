require 'carrierwave/encrypter_decrypter/openssl/aes'
require 'carrierwave/encrypter_decrypter/openssl/pkcs5'

class Decryption
  def self.start!(obj,opts)
    encryption_type = Carrierwave::EncrypterDecrypter.configuration.encryption_type

    case encryption_type
    when :aes
      Openssl::Aes.decrypt_for(obj,opts)
    when :pkcs5
      Openssl::Pkcs5.decrypt_for(obj,opts)
    end
  end
end
