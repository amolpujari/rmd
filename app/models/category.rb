class Category < ActiveRecord::Base
  validates_uniqueness_of :name, :case_sensitive => true

  has_and_belongs_to_many :products
  accepts_nested_attributes_for :products

  extend Searchable

  def self.q _q
    _q = validated_query(_q)
    return where(nil) unless _q

    select('categories.name, categories.id').where(id: joins(:products).where('products.name ILIKE ? OR categories.name ILIKE ?', "%#{_q}%", "%#{_q}%").limit(100).pluck(:id).uniq )
  end

  def self.root limit=nil
    unless limit.try(:to_i) and limit.try(:to_i) > 1
      limit = 20
    end

    where('categories.parent_id IS NULL').order('categories.name').limit(limit)
  end

  def self.total
    # Rails.cache.fetch("Category#total", expires_in: 12.hours) do
      self.select('id').count
    # end
  end
end
