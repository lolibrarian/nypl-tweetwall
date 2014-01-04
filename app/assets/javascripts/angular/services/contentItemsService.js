app.service('contentItemsService', function ($http) {
  // Returns an API URL for the given category slug.
  function url(categorySlug) {
    return '/api/content_items/' + categorySlug + '.json';
  }

  // Returns a promise for Content Items from the API for the given category
  // slug.
  this.get = function (categorySlug) {
    return $http.get(url(categorySlug));
  };
});
