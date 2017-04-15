# Stripe Charges
class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    amount = params[:amount].keys.first.to_f * 100
    @amount = amount.to_i

    # TODO: create an alternate ship to address not related to the user
    # current_user.update(user_params)

    if current_user.address1.blank? && current_user.city.blank? &&
       current_user.state.blank?
      current_user.update(
        lastname: user_params[:lastname],
        address1: params[:stripeShippingAddressLine1],
        address2: params[:stripeShippingAddressApt],
        city: params[:stripeBillingAddressCity],
        state: params[:stripeBillingAddressState],
        zip: params[:stripeBillingAddressZip]
      )
    end
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )

    # TODO: Create OrderProcessorClass to handle this transaction
    current_user.cart.orders.each do |order|
      if order.order_status == 'pending-payment'
        Inventory.reduce_current_quantity(order.order_items)
        order.order_status = 'pending-shipping'
        order.save!

        order_history = OrderHistory.create(user_id: order.user_id, total: order.total,
                                     quantity: order.quantity, guid: order.guid)
        order.order_items.each do |item|
          OrderedItemHistory.create(order_history_id: order_history.id,
                                    meal_id: item.meal_id, quantity: item.quantity,
                                    total_price: item.total_price)
        end

        binding.pry
        # TODO: Place order in 'order history', delete order and remove items from cart"
      end
    end

      #TODO:  "Fire off a confirmation email process"

    redirect_to controller: 'cart', action: 'account', locals: { paid: @amount }

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :address1,
                                 :address2, :city, :state, :zip, :phone)
  end
end
