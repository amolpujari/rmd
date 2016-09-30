class Category < ActiveRecord::Base
  validates_uniqueness_of :name, :case_sensitive => true

  has_and_belongs_to_many :products
  accepts_nested_attributes_for :products

  def self.select_name_id
    select('categories.name, categories.id').pluck :name, :id
  end

  def self.q _q
    _q = _q.to_s.strip
    return where(nil) if _q.length < 2
    return where(nil) if _q.length > 10

    where("categories.name ILIKE ?", "%#{_q}%")
  end

  def self.root limit=nil
    unless limit.try(:to_i) and limit.try(:to_i) > 1
      limit = 20
    end

    where('categories.parent_id IS NULL').order('categories.name').limit(limit)
  end
end
