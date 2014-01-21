# NYPL Tweetwall

<a href='https://codeclimate.com/github/lolibrarian/nypl-tweetwall'>
  <img src='https://codeclimate.com/github/lolibrarian/nypl-tweetwall.png' alt='Code Climate rating' />
</a>

The NYPL Tweetwall presents content from library collections that are currently being discussed on Twitter. See it in action [here](http://nypl-tweetwall.herokuapp.com)!

<img width=600 src='https://f.cloud.github.com/assets/544541/1869229/effaed8e-7877-11e3-964e-af7080a71a7a.png' alt='Screenshot of NYPL Tweetwall' />

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

There is [one Rake task](https://github.com/lolibrarian/nypl-tweetwall/blob/master/lib/tasks/tweetwall.rake) responsible for updating the Tweetwall:

```bash
foreman run rake tweetwall:update
```

It performs the following sub-tasks:

  * Deletes expired content
  * Deletes expired Tweets
  * Checks for new Tweets
  * Adds new content
  * Expires and warms the cache

## Contributing

Bug reports, fixes, and new features are welcomed. If you'd like to contribute code, please:

  1. Fork the project

  2. Start a branch named for your new feature or bug

  3. Run (and add to, if possible) the unit tests:

    ```bash
    bundle exec rake test
    ```

  4. Create a Pull Request

Thank you!
