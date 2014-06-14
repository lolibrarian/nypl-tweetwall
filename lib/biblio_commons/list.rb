module BiblioCommons
  class List
    BASE_LIST_URI = URI.parse("http://nypl.bibliocommons.com/list/show")

    # Extracts a BiblioCommons list ID from the given URL.
    def self.id_from_url(url)
      uri = URI(url)
      return unless uri.host == BASE_LIST_URI.host

      matches = uri.path.scan(/\A\/list\/(show|share)\/\w+\/(\d+)/).first
      return if matches.nil?

      matches.last
    end

    def initialize(list_id, user_id = nil)
      @list_id = list_id
      @user_id = user_id
    end

    def url
      "#{BASE_LIST_URI}/#{@user_id}/#{@list_id}"
    end

    def name
      CGI.unescapeHTML(lists["name"])
    end

    def user_id
      @user_id ||= lists["user"]["id"]
    end

    def thumbnail_url
      return unless list_items.any?

      # Find the first "title" list item (lists can comprise of more than just
      # physical items, for example, URLs).
      title_list_item = list_items.find do |list_item|
        list_item['list_item_type'] == 'title'
      end

      return unless title_list_item

      title = Title.new(title_list_item['title']['id'])
      title.thumbnail_url
    end

  private

    def lists
      @lists ||= API.get("lists/#{@list_id}")["list"]
    end

    def list_items
      lists["list_items"]
    end
  end
end
