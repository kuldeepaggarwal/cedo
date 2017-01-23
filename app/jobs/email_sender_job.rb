class EmailSenderJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) do |exception|
    retry_job wait: 3.minutes, queue: :default
  end

  def perform(buyer_email, buyer_name, amazon_order_id, asins)
    order = Order.new(BuyerEmail: buyer_email, BuyerName: buyer_name, AmazonOrderId: amazon_order_id)
    if asins.present?
      _asins = asins.split(',').map(&:strip).select(&:present?)
      mail_sending = _asins.include?(order.asin)
    else
      mail_sending = true
    end
    FeedbackMailer.product_feedback(order.buyer_email, order.buyer_name, order.feedback_url, order.title)
                  .deliver_later! if mail_sending
  end
end
