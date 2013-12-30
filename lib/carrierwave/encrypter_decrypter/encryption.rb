require 'carrierwave/encrypter_decrypter/openssl/aes'

class Encryption
	def self.start!(obj)
		encryption_type = Carrierwave::EncrypterDecrypter.configuration.encryption_type

		case encryption_type
		when :aes
			Openssl::Aes.encrypt_for(obj)
		end
	end
end