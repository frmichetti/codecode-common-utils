require 'codecode/common/utils/version'

module CodeCode
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
            memo[k.to_sym] = symbolize_keys v if v.class.to_s.eql? 'Hash'
            memo
          }
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
      end
    end
  end
end