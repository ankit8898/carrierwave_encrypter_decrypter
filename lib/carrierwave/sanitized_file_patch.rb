# encoding: utf-8
module CarrierWave
  class SanitizedFile

    ##
    # Returns the file's size.
    #
    # === Returns
    #
    # [Integer] the file's size in bytes.
    #
    def size
      if is_path?

        if exists?
          File.size(path)
        elsif defined? Carrierwave::EncrypterDecrypter
          File.size(path + '.enc') rescue 0
        else
          0
        end

      elsif @file.respond_to?(:size)
        @file.size
      elsif path
        exists? ? File.size(path) : 0
      else
        0
      end
    end

    ##
    # Removes the file from the filesystem.
    #
    def delete
      if exists?
        FileUtils.rm(self.path)
      else
        if defined? Carrierwave::EncrypterDecrypter
          new_path = self.path + '.enc'
          FileUtils.rm(new_path) if File.exists?(new_path)
        end
      end
    end

  end # SanitizedFile
end # CarrierWave