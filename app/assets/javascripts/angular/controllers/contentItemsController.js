app.controller('ContentItemsController', function ($scope,
                                                   $interval,
                                                   $timeout,
                                                   navigationService,
                                                   alertsService,
                                                   paginationService,
                                                   masonryService,
                                                   contentItemsService,
                                                   contentItemsDecoratorFactory) {
  var CONTENT_ITEMS_POLLING_FREQUENCY = 60000;

  initialize();

  function initialize() {
    initializeNavigation();
    initializeAlerts();
    initializeContentItems();
    initializePagination();
    initializeMasonry();
    navigationService.setCategorySlug('all');
  }

  function initializeNavigation() {
    $scope.categories = navigationService.categories;
    $scope.getCategorySlug = navigationService.getCategorySlug;
    $scope.setCategorySlug = navigationService.setCategorySlug;
    $scope.classForCategorySlug = navigationService.classForCategorySlug;
    $scope.$watch('getCategorySlug()', function () {
      $scope.$emit('navigation');
    });
    $scope.$on('navigation', function () {
      // Because the navigation is affixed to the top of the viewport, when
      // used, to show the newest content first, scroll to the top of the page.
      window.scrollTo(0, 0);
    });
  }

  function initializeAlerts() {
    $scope.getServerError = alertsService.getServerError;
    $scope.setServerError = alertsService.setServerError;
    $scope.$watch('getServerError()', function (newValue) {
      if (newValue) { $scope.$emit('alert'); }
    });
  }

  function initializePagination() {
    $scope.$on('navigation', paginationService.resetLimit);
    $scope.getLimit = paginationService.getLimit;
    $scope.throttledNextPage = paginationService.throttledNextPage;
    $scope.paginationThrottled = paginationService.paginationThrottled;
  }

  function initializeMasonry() {
    masonryService.onPosition(function () {
      // Add a class to positioned bricks for styling purposes. A timeout is
      // used so CSS transition directives are applied only *after* the initial
      // positioning.
      var bricks = this;

      $timeout(function () {
        bricks.addClass('masonry-positioned');
      }, 0);
    });
  }

  function initializeContentItems() {
    $scope.$on('navigation', function () {
      getContentItems();
    });

    $interval(function () {
      getContentItems();
    }, CONTENT_ITEMS_POLLING_FREQUENCY);
  }

  function getContentItems(options) {
    var slug = navigationService.getCategorySlug();

    contentItemsService.get(slug, options)
      .success(function (contentItems) {
        var decorator = new contentItemsDecoratorFactory(contentItems);
        decorator.decorate();
        $scope.contentItems = contentItems;
        alertsService.setServerError(false);
      })
      .error(function (_, status) {
        alertsService.setServerError(status);
      });
  }
});
