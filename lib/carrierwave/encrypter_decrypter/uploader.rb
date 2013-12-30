#Carrierwave::EncrypterDecrypter::Uploader.encrypt("ank")
require 'carrierwave/encrypter_decrypter/encryption.rb'
module Carrierwave
	module EncrypterDecrypter
		module Uploader
			def self.encrypt(obj)
				Encryption.start!(obj)
			end
		end
	end
end

