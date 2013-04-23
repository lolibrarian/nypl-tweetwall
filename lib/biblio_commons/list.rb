module BiblioCommons
  class List
    BASE_LIST_URI = URI.parse("http://nypl.bibliocommons.com/list/show")

    # Extracts a BiblioCommons list ID from the given URL.
    def self.id_from_url(url)
      uri = URI(url)
      return unless uri.host == BASE_LIST_URI.host

      matches = uri.path.scan(/\A\/list\/show\/\w+\/(\d+)/).first
      return if matches.nil?

      matches.first
    end

    def initialize(list_id, user_id = nil)
      @list_id = list_id
      @user_id = user_id
    end

    def url
      "#{BASE_LIST_URI}/#{@user_id}/#{@list_id}"
    end

    def lists
      @lists ||= API.get("lists/#{@list_id}")["list"]
    end

    def name
      lists["name"]
    end

    def list_items
      lists["list_items"]
    end

    def user_id
      @user_id ||= lists["user"]["id"]
    end

    def thumbnail_url
      return unless list_items.any?

      title = Title.new(list_items.first["title"]["id"])
      title.thumbnail_url
    end
  end
end
