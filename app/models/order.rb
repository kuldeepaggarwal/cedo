class Order
  include Virtus.model

  attribute :BuyerEmail, String
  attribute :AmazonOrderId, String
  attribute :BuyerName, String

  def asin
    line_item['ASIN']
  end

  def title
    line_item['Title']
  end

  def feedback_url
    "#{ENV['AMAZON_BASE_URL'] || 'http://amazon.in/dp/'}#{asin}"
  end

  new.attributes.each_key do |attr_name|
    define_method attr_name.to_s.underscore do
      send(attr_name)
    end
  end

  private

    def line_item
      line_items.first['OrderItem']
    end

    def line_items
      @line_items ||= Array.wrap(response['ListOrderItemsResponse']['ListOrderItemsResult']['OrderItems'])
    end

    def response
      Hash.from_xml(MWS.orders.list_order_items(amazon_order_id).body)
    end
end
