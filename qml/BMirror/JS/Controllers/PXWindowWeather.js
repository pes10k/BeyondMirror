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
        private_current_settings = false,
        current_users_values = function () {

            if (!private_current_settings) {

                private_current_settings = valueForKey(currentUser.userId(), data_key);

                // If we don't have any settings / configuration options currently
                // set for the clock, choose some sensiable defaults.
                if (!private_current_settings) {

                    private_current_settings = {
                        "use_f_degrees" : false,
                        "location" : "Chicago, IL"
                    };
                    setValueForKey(currentUser.userId(), private_current_settings, data_key);
                }
            }

            return private_current_settings;
        };

    return {
        reset: function () {
            private_current_settings = false;
        },
        configOptions: function () {
            return current_users_values();
        },
        currentWeather: function (callback) {

            var config = current_users_values();
            weatherFetcher(config.location, callback);
        },
        setDegreeType: function (degree_type) {

            private_current_settings.use_f_degrees = degree_type === "f";
            setValueForKey(currentUser.userId(), private_current_settings, data_key);
        },
        degreeType: function () {

            var config = current_users_values();
            return config.use_f_degrees ? "f" : "c";
        }
    };
}());

var addWeatherToModel = function (model) {

    weather.currentWeather(function (weather_results) {

        var i = 0,
            config_options = weather.configOptions();

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
