module Expirable
  def expire_in(length)
    @expiration_length = length
  end

  def expired
    where("created_at < ?", @expiration_length.ago)
  end
end
