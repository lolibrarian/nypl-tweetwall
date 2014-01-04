angular.module('toddmazierski.masonry', ['toddmazierski.debounce'])
  .service('masonryService', function (debounce) {
    var container,
        positionCallback;

    // Recalculates and reapplies Masonry brick positions.
    function reload() {
      container.masonry('reload', positionCallback);
    }

    // Called by the link phase of the masonry directive to configure Masonry.
    this.configure = function (element, options) {
      container = element;
      container.masonry(options);
    };

    // Called by the link phase of the masonry-brick directive. Debounced so the
    // brick positions are recalculated less frequently when many bricks are
    // created or destroyed.
    this.debouncedReload = debounce(reload, 100, false);

    // Registers a callback to be called when Masonry bricks are positioned.
    this.onPosition = function (callback) {
      positionCallback = callback;
    };
  })
  .directive('masonry', function (masonryService) {
    function link(scope, element, attrs) {
      // Parse the JSON-formatted string assigned to the directive. Pass as
      // options for Masonry.
      var options = JSON.parse(attrs.masonry);
      masonryService.configure(element, options);
    }

    return {link: link};
  })
  .directive('masonryBrick', function (masonryService) {
    function link(scope, element) {
      masonryService.debouncedReload();

      element.on('$destroy', function () {
        masonryService.debouncedReload();
      });
    }

    return {link: link};
  });
