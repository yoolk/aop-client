module AopClient
  module Response
    class Base
      ## Attributes
      attr_reader :error, :data

      def initialize(response)
        hash = JSON.parse(response.body)

        if hash['error_response']
          @error = hash['error_response']
        else
          @data = hash
        end
        # if matched = response.body.match(/<p>Error Code: (.*)<br\/>Error Message: (.*)<\/p>/)
        #   @error_code    = matched[1]
        #   @error_message = matched[2]
        # end
      rescue
      end

    end
  end
end