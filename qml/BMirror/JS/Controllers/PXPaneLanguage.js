Qt.include("../PXStorage.js");
Qt.include("../PXApp.js");

var languages = (function () {
    var data_key = "language settings",
        current_users_values = function (user_id) {

            var settings = valueForKey(user_id, data_key);

            // If we don't have any settings / configuration options currently
            // set for the clock, choose some sensiable defaults.
            if (!settings) {

                settings = {
                    "language" : "en"
                };
                setValueForKey(user_id, settings, data_key);
            }

            return settings;
        };

    return {
        language: function (user_id) {
            var config = current_users_values(user_id);
            return config.language;
        },
        setLanguage: function (user_id, new_language) {

            var config = current_users_values(user_id);
            config["language"] = new_language;
            setValueForKey(user_id, config, data_key);
        }
    };
}());

var addLanguagesToModel = (function () {

    var current_languages = [
        {"name" : "English", "code" : "en", "image" : "america.png"},
        {"name" : "Chinese", "code" : "zh", "image" : "china.png"},
        {"name" : "Finish", "code" : "fn", "image" : "finland.png"},
        {"name" : "French", "code" : "fr", "image" : "france.png"},
        {"name" : "German", "code" : "de", "image" : "german.png"},
        {"name" : "Hebrew", "code" : "he", "image" : "israel.png"},
        {"name" : "Italian", "code" : "it", "image" : "italy.png"},
        {"name" : "Polish", "code" : "pl", "image" : "poland.png"},
        {"name" : "Spanish", "code" : "es", "image" : "spain.gif"},
        {"name" : "Swedish", "code" : "sv", "image" : "sweden.png"}
    ];

    return function (model) {

        var i = 0, a_language;

        for (i; i < current_languages.length; i++) {

            a_language = current_languages[i];

            model.append({
                "rowTextKey" : a_language.name,
                "rowLanguageCode" : a_language.code,
                "rowLanguageImage" : a_language.image,
                "isCurrent" : false
            });
        }
    };
}());
