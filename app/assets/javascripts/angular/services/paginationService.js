app.service('paginationService', function (debounce) {
  var PER_PAGE = 10,
      limit;

  // Increments the pagination limit.
  function nextPage() {
    limit += PER_PAGE;
  }

  // Resets the pagination limit.
  this.reset = function () {
    limit = PER_PAGE;
  };

  // Returns the pagination limit.
  this.getLimit = function () {
    return limit;
  };

  this.debouncedNextPage = debounce(nextPage, 300, true);
});
