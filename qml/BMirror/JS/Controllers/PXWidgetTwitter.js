Qt.include("../PXApp.js");
Qt.include("../PXStorage.js");
Qt.include("../PXUser.js");
Qt.include("../PXJSONFetcher.js");

var tweetFetcher = (function () {

    var cached_data = {};

    return function (username, callback) {

        if (cached_data[username]) {

            if (callback) {
                callback(cached_data[username]);
            }

        } else {

            fetcher.get("http://api.twitter.com/1/statuses/user_timeline.json?include_entities=false&include_rts=false&count=10&screen_name=" + username, function (results, url) {

                var tweets = [], i = 0, current_tweet;

                if (results.length > 0) {

                    for (i; i < results.length; i += 1) {

                        current_tweet = results[i];

                        tweets.push({
                            "text" : current_tweet.text,
                            "username" : username,
                            "user" : current_tweet.user.name,
                            "id" : current_tweet.id,
                            "date" : current_tweet.created_at,
                            "date_ts" : Date.parse(current_tweet.created_at)
                        });
                    }

                    cached_data[username] = tweets;

                    if (callback) {
                        callback(tweets);
                    }
                }
            });
        }
    };
}());

var tweets = (function () {

    var data_key = "followed twitter accounts",
          default_value,
          current_items = valueForKey(currentUser.userId(), data_key);

    if (!current_items) {

        // The default value we'll use is "local news", provided by
        default_value = ["gapersblock"];
        setValueForKey(currentUser.userId(), default_value, data_key);
        current_items = default_value;
    }

    return {
        reset: function () {
            current_items = valueForKey(currentUser.userId(), data_key);
        },
        // Returns an array of the all the twitter accounts the current
        // user is following.
        currentAccounts: function () {
            return current_items;
        },
        // Returns a sorted array of objects, each representing a tweet object.
        // The returned array will be a list of items, from most to least
        // recent, from all twitter feeds being followed
        currentItems: function (limit, callback) {

            var current_accounts = this.currentAccounts(),
                num_accounts = current_accounts.length,
                num_accounts_returned = 0,
                sorted_items = [],
                i = 0,
                received_items_callback = function (tweets_from_account) {

                    sorted_items.push.apply(sorted_items, tweets_from_account);
                    num_accounts_returned += 1;

                    // If this is the last feed to return, we can
                    // now sort all the returned items and return them to the
                    // callback
                    if (num_accounts_returned === num_accounts) {

                        sorted_items.sort(function (a, b) {
                            return b.date_ts - a.date_ts;
                        });

                        if (callback) {
                            callback(sorted_items.slice(0, limit));
                        }
                    }
                };

            if (!limit) {
                limit = 10;
            }

            for (i; i < num_accounts; i += 1) {

                // We perform all the queries for new tweets in parallel,
                // but only allow the last one to return feed items
                // to the callback
                tweetFetcher(current_accounts[i], received_items_callback);
            }
        },
        addAccount: function (account_name, callback) {

            if (current_items[account_name]) {

                callback(false);

            } else {

                // Build up a cache for the news items in this URL
                // immediatly, to make things quicker.
                tweetFetcher(account_name);
                current_items.push(account_name);
                setValueForKey(currentUser.userId(), current_items, data_key, callback);
            }
        },
        removeAccount: function (account_name, callback) {

            var adjusted_items = removeFromArray(account_name, current_items);

            // If the item we were trying to remove wasn't in the collection,
            // there isn't anything to do
            if (current_items === adjusted_items) {

                if (callback) {
                    callback(current_items);
                }

            } else {

                setValueForKey(currentUser.userId(), adjusted_items, data_key, callback);

            }
        }
    };
}());

var addCurrentUsersTwitterAccountsToModel = function (model) {

    var accounts = tweets.currentAccounts(),
        num_accounts = accounts.length,
        i = 0;

    for (i; i < num_accounts; i += 1) {

        model.append({
            "rowTextKey" : accounts[i]
        });
    }
};

var addCurrentUsersTwitterItemsToModel = function (model) {

    tweets.currentItems(20, function (current_tweets) {

        var i = 0, result;

        for (i; i < current_tweets.length; i += 1) {

            result = current_tweets[i];

            model.append({
                "rowTextKey" : result.text,
                "rowTwitterUrl" : "http://twitter.com/#!/" + result.username + "/status/" + result.id,
                "rowTwitterUser" : result.username,
                "rowTwitterDate" : result.date
            });
        }
    });
};
