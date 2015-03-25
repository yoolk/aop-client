module AopClient
  class ArrayIdValidator < ActiveModel::EachValidator
    def validate_each(record, attr_name, value)
      return if value.is_a?(Array) && id_like?(value)

      record.errors.add attr_name, :invalid, options
    end

    private

    def id_like?(value)
      !(value.any? { |i| !i.is_a?(Integer) || i <= 0 })
    end
  end
end
