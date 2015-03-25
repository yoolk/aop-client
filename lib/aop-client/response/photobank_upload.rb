module AopClient
  module Response
    class PhotobankUpload < Base

      def data
        return {} if super.nil?

        super[:alibaba_icbu_photobank_upload_response][:upload_image_response]
      end
    end
  end
end