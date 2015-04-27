app.service('navigationService', function ($location,
                                           $filter) {
  var currentCategorySlug,
      defaultCategorySlug = 'all',
      categories = [
        {slug: 'all',         name: 'All'},
        {slug: 'books',       name: 'Books'},
        {slug: 'lists',       name: 'Lists'},
        {slug: 'images',      name: 'Images'},
        {slug: 'blogs',       name: 'Blog Posts'},
        {slug: 'events',      name: 'Events'},
        {slug: 'audio_video', name: 'Audio/Video'}
      ];

  function findCategoryBySlug(slug) {
    return $filter('filter')(categories, {slug: slug})[0];
  }

  function categorySlugFromPath(path) {
    var slug     = path.replace('/', ''),
        category = findCategoryBySlug(slug);

    return (category ? category.slug : defaultCategorySlug);
  }

  this.categories = categories;

  // Returns the current category slug.
  this.getCategorySlug = function () {
    return currentCategorySlug;
  };

  this.attach = function ($scope) {
    $scope.$on('$locationChangeSuccess', function () {
      currentCategorySlug = categorySlugFromPath($location.path());
      $scope.$emit('navigation');
    });
  };

  // Returns a CSS class for the given category slug.
  this.classForCategorySlug = function (slug) {
    return (slug === currentCategorySlug) ? 'active' : null;
  };
});
