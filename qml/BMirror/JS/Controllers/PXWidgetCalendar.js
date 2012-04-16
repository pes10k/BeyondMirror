Qt.include("../PXApp.js");
Qt.include("../PXStorage.js");
Qt.include("../PXJSONFetcher.js");
Qt.include("../PXStrings.js");

var calendarFetcher = (function () {

    return function (user_id, callback) {

        if (!user_id) {
            if (callback) {
                callback(false);
            }
        }

        fetcher.get("http://snyderp.org/calendar-data.php?rand=" + Math.random() + "&user_id=" + user_id, function (results, url) {

            console.log("T");

            if (callback) {
                console.log("Z");
                callback(results);
            }
        });
    };
}());

var calendar = (function () {

    var data_key = "current calendar code",
            default_value,
            current_users_values = function (user_id) {

                var current_items = valueForKey(user_id, data_key);

                if (!current_items) {

                    current_items = {
                        "code" : "",
                        "token" : ""
                    };
                    setValueForKey(user_id, current_items, data_key);
                }

                return current_items;
            };

    return {
        setToken: function (user_id, token, callback) {
            var config = current_users_values(user_id);
            config.token = token;
            setValueForKey(user_id, config, data_key, callback);
        },
        currentToken: function (user_id, token, callback) {
            var config = current_users_values(user_id);
            return config.token;
        },
        setCode: function (user_id, code, callback) {
            var config = current_users_values(user_id);
            config.code = code;
            setValueForKey(user_id, config, data_key, callback);
        },
        currentCode: function (user_id) {
            var config = current_users_values(user_id);
            return config.code;
        }
    };
}());

var addEventsToModel = function (user_id, model) {

    calendarFetcher(user_id, function (results) {

        if (results && results.data && results.data.length > 0) {

            var i = 0, event;

            for (i; i < results.data.length; i++) {

                event = results.data[i];

                model.append({
                    "rowTextKey" : event.title,
                    "rowEventStart" : event.start_format
                });
            }

        } else {

            model.append({
                "rowTextKey" : "Not connected to GoogleCalendar",
                "rowEventStart" : ""
            });
        }
    });
};

