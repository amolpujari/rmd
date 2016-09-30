# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Product.destroy_all
Category.destroy_all

puts 'seeding...'
1.upto(100).each do |i|
  parent_id = Category.all.sample.id rescue nil
  c = Category.new name: Faker::SlackEmoji.objects_and_symbols.to_s.delete(':')
  if i>10
    c.parent_id = parent_id
  end
  c.save rescue nil
end

cats_count = Category.count - 1

t1 = Time.now
1.upto(100000).each do |i|
  p = Product.create name: "#{Faker::Commerce.product_name} #{Time.now.to_i.to_s[7..-1]}", price: Faker::Commerce.price, description: Faker::Hipster.paragraph rescue nil
  c = Category.all.sample
  p.categories << c
  
  if Time.now-t1>10
    puts "#{Product.count} unique products.... trying to add #{100000 - i} more..."
    t1 = Time.now
  end
end

puts "Seeded #{Product.count} unique products with #{Category.count} unique categories."

