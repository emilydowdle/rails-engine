class MerchantDataParser
  def sort_merchants_by_sales
    # Merchant.all.map { |merchant| merchant.sum_of_successful_transactions }.sort.reverse.take(num_to_take)
    Merchant.order.Merchant.sum_of_successful_transactions
  end
end
