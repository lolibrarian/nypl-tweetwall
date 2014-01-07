app.service('paginationService', function ($timeout) {
  var THROTTLE_DELAY = 1000,
      PER_PAGE = 10,
      limit,
      throttled;

  // Wraps the given function. Before it's called, toggles the throttle on.
  // After the THROTTLE_DELAY, toggles the throttle off again.
  function throttle(func) {
    return function () {
      throttled = true;
      func();
      $timeout(function () {
        throttled = false;
      }, THROTTLE_DELAY);
    };
  }

  // Increments the pagination limit.
  function nextPage() {
    limit += PER_PAGE;
  }

  // Increments the pagination limit and toggles the throttle.
  this.throttledNextPage = throttle(nextPage);

  // Returns true if pagination is currently being throttled.
  this.paginationThrottled = function () {
    return throttled;
  };

  // Resets the pagination limit.
  this.resetLimit = function () {
    limit = PER_PAGE;
  };

  // Returns the pagination limit.
  this.getLimit = function () {
    return limit;
  };
});
