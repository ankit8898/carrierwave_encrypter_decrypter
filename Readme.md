# Carrierwave Encrypter Decrypter

A Rubygem to secure the file uploaded by encrypting the data and decryption on the fly.  Completely secure and depends on Ruby 2.0.0 OpenSSL::Cipher and OpenSSL::PKCS5


## Installation

Add the gem to the Gemfile:

    gem "carrierwave_encrypter_decrypter"    

bundle install

## Getting Started

Start off by trigerring the installer

	rails g ced:install


This will create a initializer `carrierwave_encrypter_decrypter`

    create  config/initializers/carrierwave_encrypter_decrypter.rb


Now in your Uploader for eg `app/uploaders/avatar_uploader.rb` add the after store callback

	
	class AvatarUploader < CarrierWave::Uploader::Base
		after :store, :encrypt_file
	
		def encrypt_file(file)
  	  		Carrierwave::EncrypterDecrypter::Uploader.encrypt(self)
		end
	end

Now create the migration on the model on which your uploader is mounted

	rails g migration add_iv_and_key_to_users iv:binary key:binary
	rake db:migrate

**File Encryption**

The File encryption will happen with `Carrierwave::EncrypterDecrypter::Uploader.encrypt(self)` once the file is uploaded you will find it with a extendion of `.enc`


**File Decryption**


The File Decryption will happen with 

	Carrierwave::EncrypterDecrypter::Downloader.decrypt(model,mounted_as: :avatar)

Where `Model` is the model on which the uploader is mounted.  The Encrypted file will be decrypted in the same folder.

Eg Controller

	def download
	  #This will decryt the file first

	  Carrierwave::EncrypterDecrypter::Downloader.decrypt(@user,mounted_as: :avatar)

	  file_path = @user.avatar.path
	    File.open(file_path, 'r') do |f|
	      send_data f.read, type: MIME::Types.type_for(file_path).first.content_type,disposition: :inline,:filename => File.basename(file_path)
	  end
	    #This is to remove the decrypted file after transfer
	    File.unlink(file_path)
	end



## Licensing


The gem itself is released under the MIT license

:pray: