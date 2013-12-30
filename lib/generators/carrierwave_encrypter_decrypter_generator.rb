class CarrierwaveEncrypterDecrypterGenerator < Rails::Generators::Base
	desc "This generator creates an initializer file at config/initializers"
  def create_initializer_file
    create_file "config/initializers/carrierwave_encrypter_decrypter.rb", "# Add initialization content here"
  end
end