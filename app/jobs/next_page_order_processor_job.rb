class NextPageOrderProcessorJob < ApplicationJob
  queue_as :default

  def perform(token, asins)
    response(token, asins).orders.each_with_index do |order, index|
      EmailSenderJob.set(wait: (index * 10).seconds).perform_later(order.buyer_email, order.buyer_name, order.amazon_order_id, asins)
    end
  end

  private

    def response(token, asins)
      response = MWS.orders.list_orders_by_next_token(token).body
      AmazonOrders::Response.new(response, first_page: false, asins: asins)
    end
end
