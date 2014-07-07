require 'rails/generators/named_base'

module Ced
  module Generators
    class Base < ::Rails::Generators::NamedBase
      def self.source_root
        @_ced_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'ced', generator_name, 'templates'))
      end

      if ::Rails::VERSION::STRING < '3.1'
        def module_namespacing
          yield if block_given?
        end
      end
    end
  end
end
