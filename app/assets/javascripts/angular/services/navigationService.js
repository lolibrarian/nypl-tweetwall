app.service('navigationService', function () {
  var currentCategorySlug;

  this.categories = [
    {slug: 'all',         name: 'All'},
    {slug: 'books',       name: 'Books'},
    {slug: 'lists',       name: 'Lists'},
    {slug: 'images',      name: 'Images'},
    {slug: 'blogs',       name: 'Blog Posts'},
    {slug: 'events',      name: 'Events'},
    {slug: 'audio_video', name: 'Audio/Video'}
  ];

  // Returns the current category slug.
  this.getCategorySlug = function () {
    return currentCategorySlug;
  };

  // Sets the current category slug.
  this.setCategorySlug = function (slug) {
    currentCategorySlug = slug;
  };

  // Returns a CSS class for the given category slug.
  this.classForCategorySlug = function (slug) {
    return (slug === currentCategorySlug) ? 'active' : null;
  };
});
