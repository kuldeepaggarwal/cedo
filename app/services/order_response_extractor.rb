module OrderResponseExtractor
  HIERARCHY = {
    true => ['ListOrdersResponse', 'ListOrdersResult'],
    false => ['ListOrdersByNextTokenResponse', 'ListOrdersByNextTokenResult']
  }
  module_function

  def orders(response, first_page = true)
    response.dig(*HIERARCHY[first_page]).dig('Orders', 'Order') || []
  end

  def next_token(response, first_page = true)
    response.dig(*HIERARCHY[first_page]).dig('NextToken')
  end
end
