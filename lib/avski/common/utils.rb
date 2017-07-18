require 'avski/common/utils/version'
require 'avski/common/exceptions'

include Avski::Common::Exceptions

module Avski
  module Common
    module Utils

      # Utility methods for Hash manipulation
      module Hash

        # Convert Hash string keys to symbol keys
        #
        # @param [Hash] hash
        # @return [Hash] The resulting hash with symbolized keys
        def self.symbolize_keys(hash)
          hash.inject({}){ |memo, (k, v)|
            memo[k.to_sym] = v
            memo[k.to_sym] = symbolize_keys v if v.class.eql? ::Hash
            memo
          }
        end

        # BANG! Convert Hash string keys to symbol keys
        #
        # @param [Hash] hash
        # @return [Hash] The resulting hash with symbolized keys
        def self.symbolize_keys!(hash)
          new_hash = hash.inject({}){ |memo, (k, v)|
            memo[k.to_sym] = v
            memo[k.to_sym] = symbolize_keys v if v.class.eql? ::Hash
            memo
          }
          hash.replace new_hash
        end

        # Removes a key from the hash and return the modified hash
        #
        # @param [Hash] hash
        # @param [Symbol] key
        # @return [Hash] The given hash without the removed key
        def self.except(hash, key)
          hash.delete(key)
        end

        # Return a new hash only with the specified keys
        #
        # @param [Hash] hash
        # @param [Array] keys
        # @return [Hash]
        def self.select(hash, keys)
          hash.select { |k, v| keys.include?(k) }
        end

        # Utility methods for Validation
        module Validation

          # Check if fields used in method params have their values
          # empty or keys are missing
          # @param [Array[Symbol]] required_fields array of symbols
          # @param [Object] params
          def self.check_fields(required_fields, params)
            required_fields, missing, empty, null = required_fields, [], [], []
            required_fields.each { |key|
              missing.push(key) unless params.keys.include?(key)
              empty.push(key) if params[key.to_sym].eql?('')
              null.push(key) if params[key.to_sym].nil?
            }

            raise UnknownFieldException.new("Missing field(s) -> #{missing.join(', ')}.", 400) if missing.length > 0

            raise EmptyFieldException.new("Empty field(s) -> #{empty.join(', ')}.", 400) if empty.length > 0

            raise NullFieldException.new("Null field(s) -> #{null.join(', ')}.", 400) if null.length > 0
          end
        end
      end
    end
  end
end