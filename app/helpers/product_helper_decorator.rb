Spree::ProductsHelper.class_eval do
  def variant_hash(variant)
    price = variant.amount_in(current_currency) || variant.price

    {
      :id => variant.id,
      :in_stock => variant.in_stock?,
      :price => Spree::Money.new(price, currency: current_currency, with_currency: Spree::Config[:display_currency]).to_s
    }
  end

  def variant_options_hash(product)
    return @_variant_options_hash if @_variant_options_hash
    hash = {}
    product.variants.includes(:option_values).each do |variant|
      variant.option_values.each do |ov|
        otid = ov.option_type_id.to_s
        ovid = ov.id.to_s
        hash[otid] ||= {}
        hash[otid][ovid] ||= {}
        hash[otid][ovid][variant.id.to_s] = variant_hash(variant)
      end
    end
    @_variant_options_hash = hash
  end
end
