module AopClient
  class CommaNumericValidator < ActiveModel::EachValidator

    def validate_each(record, attr_name, value)
      if value !~ /\A(\d+)(,\d+)*\z/
        record.errors.add attr_name, :invalid, options
      end
    end

  end
end