module CartHelper
  def paid_amount amount
    amount.to_i / 100.to_f
  end
end
