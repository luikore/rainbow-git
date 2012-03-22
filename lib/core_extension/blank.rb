class Object
  def present?
    true
  end

  def blank?
    false
  end
end

class NilClass
  def present?
    false
  end

  def blank?
    true
  end
end

class FalseClass
  def present?
    false
  end

  def blank?
    true
  end
end

class Array
  alias blank? empty?

  def present?
    !empty?
  end
end

class Hash
  alias blank? empty?

  def present?
    !empty?
  end
end

class String
  alias blank? empty?

  def present?
    !empty?
  end
end
