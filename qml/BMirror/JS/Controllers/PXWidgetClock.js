Qt.include("../PXStorage.js");
Qt.include("../PXUser.js");

var clock = (function () {

    var data_key = "clock settings",
        _current_settings = false,
        current_users_values = function () {

            if (!_current_settings) {

                _current_settings = valueForKey(currentUser.userId(), data_key);

                // If we don't have any settings / configuration options currently
                // set for the clock, choose some sensiable defaults.
                if (!_current_settings) {

                    _current_settings = {
                        "hours_24" : false
                    };
                    setValueForKey(currentUser.userId(), _current_settings, data_key);
                }
            }

            return _current_settings;
        },
        zero_pad = function (a_number) {

            if (a_number < 10) {
                a_number = "0" + a_number;
            }

            return a_number;
        };

    return {
        reset: function () {
            _current_settings = false;
        },
        currentFormattedTime: function () {

            var config = current_users_values(),
                date = new Date();

            if (config.hours_24) {

                return zero_pad(date.getHours()) + ":" + zero_pad(date.getMinutes()) + ":" + zero_pad(date.getSeconds());

            } else {

                return zero_pad(date.getHours() % 12) + ":" + zero_pad(date.getMinutes()) + ":" + zero_pad(date.getSeconds()) + " " + (date.getHours() < 12 ? "AM" : "PM");

            }
        },
        is24HourTime: function () {

            var config = current_users_values();
            return config.hours_24;
        },
        setConfigOptions: function (option, value) {

            _current_settings[option] = value;
            setValueForKey(currentUser.userId(), _current_settings, data_key);
        }
    }
}());
