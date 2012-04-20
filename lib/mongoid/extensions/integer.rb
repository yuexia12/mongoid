# encoding: utf-8
module Mongoid
  module Extensions
    module Integer

      def __mongoize_time__
        ::Time.at(self)
      end

      # Is the object not to be converted to bson on criteria creation?
      #
      # @example Is the object unconvertable?
      #   object.unconvertable_to_bson?
      #
      # @return [ true ] If the object is unconvertable.
      #
      # @since 2.2.1
      def unconvertable_to_bson?
        true
      end

      module ClassMethods

        # Turn the object from the ruby type we deal with to a Mongo friendly
        # type.
        #
        # @example Mongoize the object.
        #   BigDecimal.mongoize("123.11")
        #
        # @return [ String ] The object mongoized.
        #
        # @since 3.0.0
        def mongoize(object)
          unless object.blank?
            __numeric__(object).to_i rescue 0
          else
            nil
          end
        end
      end
    end
  end
end

::Integer.__send__(:include, Mongoid::Extensions::Integer)
::Integer.__send__(:extend, Mongoid::Extensions::Integer::ClassMethods)
