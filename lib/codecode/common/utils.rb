require 'codecode/common/utils/version'
require 'codecode/common/exceptions'

include CodeCode::Common::Exceptions

module CodeCode
  module Common
    module Utils

      # Utility methods for Hash manipulation
      module Hash
        # Convert Hash string keys to symbol keys
        #
        # @param [Hash] hash
        # @return [Hash] The resulting hash with symbolized keys
        def symbolize_keys(hash)
          hash.inject({}){ |memo, (k, v)|
            memo[k.to_sym] = v
            if v.class.eql? ::Hash
              memo[k.to_sym] = symbolize_keys v
            elsif v.class.eql? ::Array
              memo[k.to_sym] = symbolize_keys_of_hashs v
            end
            memo
          }
        end

        # BANG! Convert Hash string keys to symbol keys
        #
        # @param [Hash] hash
        # @return [Hash] The resulting hash with symbolized keys
        def symbolize_keys!(hash)
          new_hash = hash.inject({}){ |memo, (k, v)|
            memo[k.to_sym] = v
            if v.class.eql? ::Hash
              memo[k.to_sym] = symbolize_keys! v
            elsif v.class.eql? ::Array
              memo[k.to_sym] = symbolize_keys_of_hashs! v
            end
            memo
          }
          hash.replace new_hash
        end

        # Convert Hash Array with string keys to symbol keys
        # @param [Object] array_of_hashs Array of String Hash
        # @return [Object] Array of Symbol Hash
        def symbolize_keys_of_hashs(array_of_hashs)
          array_of_hashs.collect{|hash| symbolize_keys(hash)}
        end

        # BANG! Convert Hash Array with string keys to symbol keys
        # @param [Object] array_of_hashs Array of String Hash
        # @return [Object] Array of Symbol Hash
        def symbolize_keys_of_hashs!(array_of_hashs)
          array_of_hashs.collect!{|hash| symbolize_keys(hash)}
        end

        def recursive_key_symbolizer!(object)
          if object.class.eql? ::Array
            symbolize_keys_of_hashs! object
          elsif object.class.eql? ::Hash
            symbolize_keys! object
          end
        end

        def recursive_key_symbolizer(object)
          if object.class.eql? ::Array
            symbolize_keys_of_hashs object
          elsif object.class.eql? ::Hash
            symbolize_keys object
          end
        end

        # Removes a key from the hash and return the modified hash
        #
        # @param [Hash] hash
        # @param [Symbol] key
        # @return [Hash] The given hash without the removed key
        def except(hash, key)
          hash.delete(key)
        end

        # Return a new hash only with the specified keys
        #
        # @param [Hash] hash
        # @param [Array] keys
        # @return [Hash]
        def select(hash, keys)
          hash.select { |k, v| keys.include?(k) }
        end
      end

      # Utility methods for Validation
      module Validation

        # Check if fields used in method params have their values
        # empty or keys are missing
        # @param [Array[Symbol]] required_fields array of symbols
        # @param [Object] params
        def check_fields(required_fields, params)
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