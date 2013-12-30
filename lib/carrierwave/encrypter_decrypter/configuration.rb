module Carrierwave
	module EncrypterDecrypter
			def self.configure
				yield configuration
			end

			def self.configuration
				@configuration ||= Carrierwave::EncrypterDecrypter::Configuration.new
			end

			class Configuration
				attr_accessor  :encryption_type, :key_size
			end
		end
end