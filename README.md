# NYPL Tweetwall

The NYPL Tweetwall presents content from library collections that are currently being discussed on Twitter.

See it in action at: http://nypl-tweetwall.herokuapp.com

## Configuration

Credentials for several APIs are required to update the Tweetwall:

  * [Twitter](https://dev.twitter.com/)
  * [BiblioCommons](http://developer.bibliocommons.com/)
  * [NYPL Digital Collections API](http://api.repo.nypl.org/)

They're passed via environment variables to the application, so creating a `.env` file for [Foreman](https://github.com/ddollar/foreman) is recommended:

    TWITTER_CONSUMER_KEY=foo
    TWITTER_CONSUMER_SECRET=bar
    TWITTER_OAUTH_TOKEN=baz
    TWITTER_OAUTH_TOKEN_SECRET=qux
    BIBLIOCOMMONS_API_KEY=foo
    DIGITAL_COLLECTIONS_API_TOKEN=qux

## Updating

There is one Rake task responsible for updating the Tweetwall:

    foreman run rake tweetwall:update

It performs the following sub-tasks:

  * Deleting expired content
  * Deleting expired Tweets
  * Checking for new Tweets
  * Adding new content
  * Expiring and re-warming the cache
