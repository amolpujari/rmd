module Searchable
  def validated_query q
    q = q.to_s.strip.scan(/\w+/).first
    return nil if q.blank?
    return nil if q.length < 2

    q = q.singularize

    q = q[0..5] if q.length>7

    q
  end

  def validated_pagination page, per_page
    if page.respond_to? :to_i
      page = page.to_i
    else
      page = 1
    end

    page = 1 if page < 1
    page = 100 if page > 100

    if per_page.respond_to? :to_i
      per_page = page.to_i
    else
      per_page = 100
    end

    per_page = 100 if per_page==0

    per_page = 20 if per_page < 20
    per_page = 100 if per_page > 100

    limit = per_page
    offset = ( (page-1) * per_page)
    offset = 0 if offset < 0

    [limit, offset]
  end
end