Product.destroy_all
Category.destroy_all

puts 'seeding...'

t1 = Time.now
1.upto(10000).each do |i|

  product_name = Faker::Commerce.product_name
  p = Product.create name: "#{product_name} #{Time.now.to_i.to_s[7..-1]}", price: Faker::Commerce.price, description: Faker::Hipster.paragraph rescue nil
  next unless p
  
  product_name.scan(/\w+/).each do |category_name|
    next if category_name.length < 3

    c = Category.where(name: category_name).first_or_create
    p.categories << c
  end

  if Time.now-t1>10
    puts "#{Product.count} unique products.... trying to add #{10000 - i} more..."
    t1 = Time.now
  end
end

puts "Seeded #{Product.count} unique products with #{Category.count} unique categories."

