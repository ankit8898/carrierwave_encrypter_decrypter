require 'carrierwave/encrypter_decrypter/openssl/aes'

class Decryption
	def self.start!(obj,opts)
		encryption_type = Carrierwave::EncrypterDecrypter.configuration.encryption_type

		case encryption_type
		when :aes
			Openssl::Aes.decrypt_for(obj,opts)
		end
	end
end