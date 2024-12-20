# message_media_messages
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module MessageMediaMessages
  # Base controller.
  class BaseController
    attr_accessor :http_client, :http_call_back, :account_id

    def initialize(http_client: nil, http_call_back: nil, account_id: nil)
      @http_client = http_client || FaradayClient.new
      @http_call_back = http_call_back
      @account_id = account_id

      @global_headers = {
        'user-agent' => 'messagemedia-messages'
      }
      @global_headers['Account'] = account_id unless account_id.nil?

    end

    def validate_parameters(args)
      args.each do |_name, value|
        if value.nil?
          raise ArgumentError, "Required parameter #{_name} cannot be nil."
        end
      end
    end

    def execute_request(request, binary: false)
      @http_call_back.on_before_request(request) if @http_call_back

      APIHelper.clean_hash(request.headers)
      request.headers = @global_headers.clone.merge(request.headers)

      response = if binary
                   @http_client.execute_as_binary(request)
                 else
                   @http_client.execute_as_string(request)
                 end
      context = HttpContext.new(request, response)

      @http_call_back.on_after_response(context) if @http_call_back

      context
    end

    def validate_response(context)
      if context.response.status_code == 400
        raise APIException.new('Request was invalid',
                               context)
      elsif context.response.status_code == 404
        raise APIException.new('Message not found',
                               context)
      end
      raise APIException.new 'HTTP Response Not OK', context unless
        context.response.status_code.between?(200, 208) # [200,208] = HTTP OK
    end
  end
end
