module Expirable
  def expires_in(length, key = :created_at)
    @expiration_length = length
    @expiration_key = key
  end

  def expired
    where("? < ?",@expiration_key, @expiration_length.ago)
  end
end
