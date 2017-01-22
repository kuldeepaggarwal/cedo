class OrderProcessorJob < ApplicationJob
  queue_as :default

  def perform(_start_date, _end_date)
    start_date = Time.parse(_start_date)
    end_date = Time.parse(_end_date)
    Rails.logger.info [start_date, end_date]
    AmazonOrders.new(start_date: start_date, end_date: end_date).each.with_index do |order, index|
      EmailSenderJob.set(wait: (index * 10).seconds).perform_later(order.buyer_email, order.buyer_name, order.amazon_order_id)
    end
  end
end
