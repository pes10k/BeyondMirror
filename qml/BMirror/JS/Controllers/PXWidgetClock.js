Qt.include("../PXStorage.js");

var clock = (function () {

    var data_key = "clock settings",
        current_users_values = function (user_id) {

            var current_settings = valueForKey(user_id, data_key);

            // If we don't have any settings / configuration options currently
            // set for the clock, choose some sensiable defaults.
            if (!current_settings) {

                current_settings = {
                    "hours_24" : false
                };
                setValueForKey(user_id, current_settings, data_key);
            }

            return current_settings;
        },
        zero_pad = function (a_number) {

            if (a_number < 10) {
                a_number = "0" + a_number;
            }

            return a_number;
        };

    return {
        currentFormattedTime: function (user_id) {

            var config = current_users_values(user_id),
                date = new Date();

            if (config.hours_24) {

                return zero_pad(date.getHours()) + ":" + zero_pad(date.getMinutes()) + ":" + zero_pad(date.getSeconds());

            } else {

                return (date.getHours() % 12) + ":" + zero_pad(date.getMinutes()) + ":" + zero_pad(date.getSeconds()) + " " + (date.getHours() < 12 ? "AM" : "PM");

            }
        },
        is24HourTime: function (user_id) {

            var config = current_users_values(user_id);
            return config.hours_24;
        },
        setConfigOptions: function (user_id, option, value) {

            var config = current_users_values(user_id);
            config[option] = value;
            setValueForKey(user_id, config, data_key);
        }
    }
}());
