require 'test_helper'

class FeedbackMailerTest < ActionMailer::TestCase
  test "product_feedback" do
    mail = FeedbackMailer.product_feedback
    assert_equal "Product feedback", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
