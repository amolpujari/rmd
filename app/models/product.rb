class Product < ActiveRecord::Base
  validates_uniqueness_of :name, :case_sensitive => true

  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories

  extend Searchable

  def categories_name
    categories.select(' categories.name ').pluck(:name).join(', ')
  end

  def self.q _q, page=0, per_page=20
    _q = validated_query(_q)
    return where(nil) unless _q

    limit, offset = validated_pagination page, per_page

    joins(:categories).
      where('products.name ILIKE ? OR categories.name ILIKE ?', "%#{_q}%", "%#{_q}%").
      select(' products.id, products.name, products.price ').
      limit(limit).offset(offset)
  end

  def self.q_count _q
    _q = validated_query(_q)
    return 0 unless _q

    Rails.cache.fetch("Product#q_count:#{_q}", expires_in: 12.hours) do

      joins(:categories).
        where('products.name ILIKE ? OR categories.name ILIKE ?', "%#{_q}%", "%#{_q}%").
        select(' products.id ').
        count
    end
  end

  def self.sort sort_column='name', asc='ASC'
    sort_column = sort_column.to_s.strip
    asc = asc.to_s.strip

    sort_column = %w{name price}.include?(sort_column) ? sort_column : 'name'
    asc = %w{ASC DESC}.include?(asc) ? asc : 'ASC'

    reorder(" products.#{sort_column} #{asc}")
  end

  def self.total
    # Rails.cache.fetch("Product#total", expires_in: 12.hours) do
      self.select('id').count
    # end
  end
end
