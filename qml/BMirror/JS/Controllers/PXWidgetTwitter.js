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
                            "id" : current_tweet.id_str,
                            "date" : current_tweet.created_at,
                            "date_ts" : Date.parse(current_tweet.created_at),
                            "image_url" : current_tweet.user.profile_image_url
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
        current_prefs = function (user_id) {

            var config = valueForKey(user_id, data_key);

            if (!config) {

                // The default value we'll use is "local news", provided by
                config = ["gapersblock"];
                setValueForKey(user_id, config, data_key);
            }

            return config;
        };


    return {
        // Returns an array of the all the twitter accounts the current
        // user is following.
        currentAccounts: function (user_id) {
            return current_prefs(user_id);
        },
        // Returns a sorted array of objects, each representing a tweet object.
        // The returned array will be a list of items, from most to least
        // recent, from all twitter feeds being followed
        currentItems: function (user_id, limit, callback) {

            var current_accounts = this.currentAccounts(user_id),
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
        addAccount: function (user_id, account_name, callback) {

            var config = current_prefs(user_id);

            account_name = account_name.replace("@", "");

            if (config.indexOf(account_name) !== -1) {

                callback(false);

            } else {

                // Build up a cache for the news items in this URL
                // immediatly, to make things quicker.
                tweetFetcher(account_name);
                config.push(account_name);
                setValueForKey(user_id, config, data_key, callback);
            }
        },
        removeAccount: function (user_id, account_name, callback) {

            account_name = account_name.replace("@", "");

            var config = current_prefs(user_id),
                adjusted_items = removeFromArray(account_name, config);

            setValueForKey(user_id, adjusted_items, data_key, callback);
        }
    };
}());

var addCurrentUsersTwitterAccountsToModel = function (user_id, model) {

    var accounts = tweets.currentAccounts(user_id),
        num_accounts = accounts.length,
        i = 0;

    for (i; i < num_accounts; i += 1) {

        model.append({
            "rowTextKey" : "@" + accounts[i]
        });
    }
};

var addCurrentUsersTwitterItemsToModel = function (user_id, model) {

    tweets.currentItems(user_id, 20, function (current_tweets) {

        var i = 0, result;

        for (i; i < current_tweets.length; i += 1) {

            result = current_tweets[i];

            model.append({
                "rowTextKey" : result.text,
                "rowTwitterUrl" : "http://twitter.com/#!/" + result.username + "/status/" + result.id,
                "rowTwitterUser" : result.username,
                "rowTwitterDate" : result.date,
                "rowTwitterImageUrl" : result.image_url
            });
        }
    });
};
