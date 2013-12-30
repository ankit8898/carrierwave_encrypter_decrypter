require 'carrierwave/encrypter_decrypter/decryption.rb'
module Carrierwave
	module EncrypterDecrypter
		module Downloader
			def self.decrypt(obj,opts)
				Decryption.start!(obj,opts)
			end
		end
	end
end

