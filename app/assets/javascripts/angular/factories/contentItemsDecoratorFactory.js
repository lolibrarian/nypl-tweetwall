app.factory('contentItemsDecoratorFactory', function ($filter) {
  var ContentItemsDecorator = function (contentItems) {
    this.contentItems = contentItems;
  };

  ContentItemsDecorator.prototype = {
    // Decorates Content Items for presentation on the page.
    decorate: function () {
      this.assignClassToTruncatedTweets();
      this.removeDefaultThumbnails();
      this.assignThumbnailStyles();
    },

    // Assigns a "truncate" CSS class to tweets that ought to be truncated. The
    // rules are:
    //
    //   1. If it's not a retweet, do not truncate.
    //
    //   2. If it *is* a retweet, but the retweeted tweet isn't included in the
    //      Content Item's set of tweets, do not truncate.
    //
    //   3. Otherwise, truncate.
    //
    assignClassToTruncatedTweets: function () {
      angular.forEach(this.contentItems, function (contentItem) {
        angular.forEach(contentItem.tweets, function (tweet) {
          var retweetedTweetIncluded = ($filter('filter')
            (this, {status_id: tweet.retweeted_status_id}).length > 0);
          tweet.klass = retweetedTweetIncluded ?  'truncate' : null;
        }, contentItem.tweets);
      });
    },

    // If a thumbnail URL is the "default" thumbnail for the NYPL site, remove
    // it (this is done to de-clutter the Tweetwall).
    removeDefaultThumbnails: function () {
      var default_thumbnail_url = 'http://www.nypl.org/sites/all/themes/nypl_new/images/nypl_logo_share.jpg';

      angular.forEach(this.contentItems, function (contentItem) {
        if (contentItem.thumbnail.url === default_thumbnail_url) {
          contentItem.thumbnail = null;
        }
      });
    },

    // Pre-computes in-line styles to assign to Content Item thumbnails.
    assignThumbnailStyles: function () {
      angular.forEach(this.contentItems, function (contentItem) {
        if (!contentItem.thumbnail) { return; }

        contentItem.thumbnail.style = 'width: ' + contentItem.thumbnail.tweetwall_width + 'px; ';
        contentItem.thumbnail.style += 'height: ' + contentItem.thumbnail.tweetwall_height + 'px;';
      });
    }
  };

  return ContentItemsDecorator;
});
