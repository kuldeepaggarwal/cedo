class OrderProcessorWorker < ApplicationWorker
  def perform(_start_date, _end_date, asins)
    start_date = Time.parse(_start_date)
    end_date = Time.parse(_end_date)
    Rails.logger.info [start_date, end_date]
    AmazonOrders.new(start_date: start_date, end_date: end_date, asins: asins).each.with_index do |order, index|
      EmailSenderWorker.perform_in((index * 10).seconds, order.buyer_email, order.buyer_name, order.amazon_order_id, asins)
    end
  end
end
