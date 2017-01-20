class FeedbackMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedback_mailer.product_feedback.subject
  #
  def product_feedback(email, buyer_name, feedback_url, product_title)
    @name = buyer_name
    @feedback_url = feedback_url
    @product_title = product_title
    mail to: email, subject: 'Product Feedback'
  end
end
