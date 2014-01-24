[![Gem Version](https://badge.fury.io/rb/carrierwave_encrypter_decrypter.png)](http://badge.fury.io/rb/carrierwave_encrypter_decrypter)[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/ankit8898/carrierwave_encrypter_decrypter/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

# Carrierwave Encrypter Decrypter

A Rubygem to secure the file uploaded by encrypting the file later on decrypting when needed.  Completely secure and depends on Ruby 2.0.0 OpenSSL::Cipher and OpenSSL::PKCS5

You can find a [Sample application with usage here](https://github.com/ankit8898/carrierwave_encrypter_decrypter_example).

**OpenSSL::Cipher**

Provides symmetric algorithms for encryption and decryption. 

**OpenSSL::PKCS5**

Provides password-based encryption functionality based on PKCS#5. 

## Installation

Add the gem to the Gemfile:

    gem "carrierwave_encrypter_decrypter"    

bundle install

## Getting Started

Start off by trigerring the installer

	rails g ced:install


This will create a initializer `carrierwave_encrypter_decrypter`

    create  config/initializers/carrierwave_encrypter_decrypter.rb

and a `carrierwave_encrypter_decrypter.yml`

	create  config/carrierwave_encrypter_decrypter.yml

the above will be used when you have the `encryption_type` as `pkcs5`.

## Choosing encryption type?

The Gem support 2 ways **[OpenSSL::Cipher](http://ruby-doc.org/stdlib-2.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html)** and **[OpenSSL::PKCS5](http://ruby-doc.org/stdlib-2.0/libdoc/openssl/rdoc/OpenSSL/PKCS5.html)**

if you want to go with standard encryption in your `config/initializers/carrierwave_encrypter_decrypter.rb` select

	Carrierwave::EncrypterDecrypter.configure  do |config|
      config.encryption_type = :aes
      config.key_size = 256
 	end

if you want to go with password based encrption (pkcs5) in your `config/initializers/carrierwave_encrypter_decrypter.rb` select
	
	Carrierwave::EncrypterDecrypter.configure  do |config|
      config.encryption_type = :pkcs5
      config.key_size = 256
 	end

**Note:** Make sure you have the password set in `config/carrierwave_encrypter_decrypter.yml`


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
