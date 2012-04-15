Qt.include("../PXApp.js");
Qt.include("../PXStorage.js");
Qt.include("../PXUser.js");
Qt.include("../PXJSONFetcher.js");
Qt.include("../PXStrings.js");

var weatherFetcher = (function () {

    var cached_data = {};

    return function (location, callback) {

        if (cached_data[location]) {

            callback(cached_data[location]);

        } else {

            fetcher.get("http://snyderp.org/weather.php?location=" + encodeURIComponent(location), function (results, url) {

                if (callback) {
                    callback(results);
                }
            });
        }
    };
}());

var weather = (function () {

    var data_key = "weather settings",
        current_users_values = function (user_id) {

            var config = valueForKey(user_id, data_key);

            // If we don't have any settings / configuration options currently
            // set for the clock, choose some sensiable defaults.
            if (!config) {

                config = {
                    "use_f_degrees" : false,
                    "location" : "Chicago, IL"
                };
                setValueForKey(user_id, config, data_key);
            }

            return config;
        };

    return {
        configOptions: function (user_id) {
            return current_users_values(user_id);
        },
        currentWeather: function (user_id, callback) {

            var config = current_users_values(user_id);
            weatherFetcher(config.location, callback);
        },
        setDegreeType: function (user_id, degree_type) {

            var config = current_users_values(user_id);
            config.use_f_degrees = degree_type === "f";
            setValueForKey(user_id, config, data_key);
        },
        degreeType: function (user_id) {

            var config = current_users_values(user_id);
            return config.use_f_degrees ? "f" : "c";
        }
    };
}());

var addWeatherToModel = function (user_id, model) {

    weather.currentWeather(user_id, function (weather_results) {

        var i = 0, config_options = weather.configOptions(user_id);

        for (i; i < weather_results.length; i += 1) {

            model.append({
                "rowTextKey" : weather_results[i].day,
                "rowWeatherDegrees" : config_options.use_f_degrees ? weather_results[i].degrees_f : weather_results[i].degrees_c,
                "rowWeatherDescription" : weather_results[i].condition,
                "rowWeatherImage" : weather_results[i].image
            });
        }
    });
};
