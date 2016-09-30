class Product < ActiveRecord::Base
  validates_uniqueness_of :name, :case_sensitive => true

  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories

  def categories_name
    categories.select(' categories.name ').pluck(:name).join(', ')
  end

  def self.q _q
    _q = _q.to_s.strip
    return where(nil) if _q.length < 2
    return where(nil) if _q.length > 10

    joins(:categories).where('products.name ILIKE ? OR categories.name ILIKE ?', "%#{_q}%", "%#{_q}%")
  end

  def self.sort sort_column='name', asc='ASC'
    sort_column = sort_column.to_s.strip
    asc = asc.to_s.strip

    sort_column = %w{name price}.include?(sort_column) ? sort_column : 'name'
    asc = %w{ASC DESC}.include?(asc) ? asc : 'ASC'

    reorder(" products.#{sort_column} #{asc}")
  end


end
