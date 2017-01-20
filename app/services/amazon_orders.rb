class AmazonOrders
  class Response
    def initialize(xml_response, first_page: true)
      @xml_response = xml_response
      @first_page = first_page
    end

    def orders
      @orders ||= decorated_orders.tap { schedule_next_page_request if next_token }
    end

    def next_token
      OrderResponseExtractor.next_token(hash_response, @first_page)
    end

    private

      def filtered_orders
        filter_orders(OrderResponseExtractor.orders(hash_response, @first_page))
      end

      def decorated_orders
        filtered_orders.map { |o| Order.new(o) }
      end

      def schedule_next_page_request
        NextPageOrderProcessorJob.set(wait: 120.seconds).perform_later(next_token)
      end

      def filter_orders(values)
        values
      end

      def hash_response
        @hash_response ||= Hash.from_xml(@xml_response)
      end
  end

  def initialize(start_date:, end_date:)
    @start_date = start_date
    @end_date = end_date
    @client = MWS.orders
  end

  def inspect
    "#<AmazonOrders start_date:#{start_date}, end_date: #{end_date}>"
  end

  def each
    return to_enum(:each) unless block_given?

    response.orders.each { |o| yield(o) }
  end

  private

    attr_reader :client, :start_date, :end_date

    def response
      @response ||= begin
        response = client.list_orders(created_after: start_date.iso8601,
                                      created_before: end_date.iso8601,
                                      order_status: 'Shipped')
                          .body
        Response.new(response)
      end
    end
end
