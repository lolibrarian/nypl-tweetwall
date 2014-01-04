angular.module('toddmazierski.affix', [])
  .directive('affix', function ($timeout) {
    function link(scope, element) {
      $timeout(function () {
        element.affix({
          offset: {top: element.offset().top}
        });
      }, 0);
    }

    return {link: link};
  });
