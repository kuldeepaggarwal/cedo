class EmailSenderJob < ApplicationJob
  queue_as :default

  def perform(buyer_email, buyer_name, amazon_order_id)
    order = Order.new(BuyerEmail: buyer_email, BuyerName: buyer_name, AmazonOrderId: amazon_order_id)
    FeedbackMailer.product_feedback(order.buyer_email, order.buyer_name, order.feedback_url, order.title)
                  .deliver_now!
  end
end
