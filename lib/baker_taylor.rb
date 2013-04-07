class BakerTaylor

  class << self
    attr_accessor :user_id,
                  :password
  end

  def self.configure(&block)
    yield(self)
  end

  def self.jacket_url(isbn)
    uri = URI.parse("http://contentcafe2.btol.com/ContentCafe/Jacket.aspx")
    params = {
      :userID   => user_id,
      :password => password,
      :Value    => isbn,
      :Type     => "M"
    }
    uri.query = URI.encode_www_form(params)

    uri.to_s
  end
end
