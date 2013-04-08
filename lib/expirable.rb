module Expirable
  def self.included(base)
    base.extend(ClassMethods)
  end

  def expired?
    self.send(self.class.expiration_key) < self.class.expiration_length.ago
  end

  def unexpired?
    errors.add(self.class.expiration_key, "is expired") if expired?
  end

  module ClassMethods
    attr_accessor :expiration_length,
                  :expiration_key

    def expires_in(length, key = :created_at)
      self.expiration_length = length
      self.expiration_key = key
    end

    def expired
      where("#{expiration_key} < ?", expiration_length.ago)
    end
  end
end
