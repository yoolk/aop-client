module AopClient
  module Response
    class OAuth < Base

      def initialize(response)
        if matched = response.body.match(/<p>Error Code: (.*)<br\/>Error Message: (.*)<\/p>/)
          @error = {
            code: matched[1],
            msg:  matched[2]
          }
        end
      end

    end
  end
end