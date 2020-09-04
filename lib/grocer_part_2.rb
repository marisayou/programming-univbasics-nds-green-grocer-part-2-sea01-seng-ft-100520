require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  cart_w_coupons = cart.clone
  for i in 0...cart.length
    coupon = find_item_by_name_in_collection(cart_w_coupons[i][:item], coupons)
    if coupon 
      item_w_coupon = cart_w_coupons[i].clone
      item_w_coupon[:item] = cart_w_coupons[i][:item] + " W/COUPON"
      item_w_coupon[:price] = coupon[:cost]/coupon[:num].to_f
      
      item_count = cart_w_coupons[i][:count]
      num_in_coupon = coupon[:num]
      cart_w_coupons[i][:count] = item_count%num_in_coupon
      item_w_coupon[:count] = item_count - item_count%num_in_coupon
      cart_w_coupons.push(item_w_coupon)
    end
  end
  return cart_w_coupons
end

def apply_clearance(cart)
  cart_w_clearances = cart.clone 
  cart_w_clearances.each do |item|
    if item[:clearance] === true 
      item[:price] *= 0.80
      item[:price] = (item[:price]*100).round/100.00
    end
  end
  return cart_w_clearances
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  consolidated_cart = consolidate_cart(cart)
  cart_w_coupons = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(cart_w_coupons)
  total_cost = 0 
  final_cart.each do |item|
    total_cost += item[:count]*item[:price]
  end
  
  if total_cost > 100
    return total_cost*0.9
  end
  
  return total_cost
end
