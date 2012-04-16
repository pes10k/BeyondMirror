Qt.include("../PXApp.js");
Qt.include("../PXStorage.js");
Qt.include("../PXUser.js");
Qt.include("../PXJSONFetcher.js");
Qt.include("../PXStrings.js");

var videoSources = (function () {

    var data_key = "video preferences",
        store_prefs = function (user_id, prefs) {
            setValueForKey(user_id, prefs, data_key);
        },
        current_prefs = function (user_id) {

            var current_prefs = valueForKey(user_id, data_key);

            if (!current_prefs) {

                current_prefs = {
                  "source" : "iTunes",
                };

                store_prefs(user_id, current_prefs);
            }

            return current_prefs;
        };

    return {
        currentSource: function (user_id) {

            var config = current_prefs(user_id);
            return config.source;
        },
        setSource: function (user_id, source) {

            var config = current_prefs(user_id);
            config.source = source;
            store_prefs(user_id, config);
        }
    };
}());

var addDataSourcesToModel = (function () {

    var rows = [
        {"rowTextKey" : "iTunes", "isCurrent" : false},
        {"rowTextKey" : "XBox", "isCurrent" : false}
    ];

    return function (model) {

        var i = 0;

        for (i; i < rows.length; i++) {

            model.append(rows[i]);
        }
    };
}());
