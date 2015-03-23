module AopClient
  class CommaKeyValueValidator < ActiveModel::EachValidator

    def validate_each(record, attr_name, value)
      if value !~ /\A([a-z0-9]+:[a-z0-9]+)(,[a-z0-9]+:[a-z0-9]+)*\z/i
        record.errors.add attr_name, :invalid, options
      end
    end

  end
end