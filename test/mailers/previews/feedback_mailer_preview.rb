# Preview all emails at http://localhost:3000/rails/mailers/feedback_mailer
class FeedbackMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/feedback_mailer/product_feedback
  def product_feedback
    FeedbackMailer.product_feedback
  end

end
