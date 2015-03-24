module AopClient
  module Resource
    class Base
      include ActiveModel::Validations

      def request_params
        {}
      end

      def multipart_params
        {}
      end

      def require_access_token?
        false
      end

      def response_class
        self.class.to_s.gsub('Resource', 'Response').constantize
      end

    end
  end
end