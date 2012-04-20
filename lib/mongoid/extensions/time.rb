# encoding: utf-8
module Mongoid
  module Extensions
    module Time

      # Turn the object from the ruby type we deal with to a Mongo friendly
      # type.
      #
      # @example Mongoize the object.
      #   time.mongoize
      #
      # @return [ Time ] The object mongoized.
      #
      # @since 3.0.0
      def mongoize
        ::Time.mongoize(self)
      end

      module ClassMethods

        # Convert the object from it's mongo friendly ruby type to this type.
        #
        # @example Demongoize the object.
        #   Time.demongoize(object)
        #
        # @param [ Time ] object The time from Mongo.
        #
        # @return [ Time ] The object as a date.
        #
        # @since 3.0.0
        def demongoize(object)
          return nil if object.blank?
          object = object.getlocal unless Mongoid::Config.use_utc?
          if Mongoid::Config.use_activesupport_time_zone?
            time_zone = Mongoid::Config.use_utc? ? "UTC" : ::Time.zone
            object = object.in_time_zone(time_zone)
          end
          object
        end

        # Turn the object from the ruby type we deal with to a Mongo friendly
        # type.
        #
        # @example Mongoize the object.
        #   Time.mongoize("2012-1-1")
        #
        # @param [ Object ] object The object to mongoize.
        #
        # @return [ Time ] The object mongoized.
        #
        # @since 3.0.0
        def mongoize(object)
          return nil if object.blank?
          begin
            ::Time.at(object.__mongoize_time__.to_f).utc
          rescue ArgumentError
            raise Errors::InvalidTime.new(object)
          end
        end
      end
    end
  end
end

::Time.__send__(:include, Mongoid::Extensions::Time)
::Time.__send__(:extend, Mongoid::Extensions::Time::ClassMethods)
