Qt.include("../PXStorage.js");
Qt.include("../PXUser.js");
Qt.include("../PXApp.js");

var languages = (function () {
    var data_key = "language settings",
        private_settings = {},
        current_users_values = function () {

            if (!private_settings["language"]) {

                private_settings = valueForKey(currentUser.userId(), data_key);

                // If we don't have any settings / configuration options currently
                // set for the clock, choose some sensiable defaults.
                if (!private_settings) {

                    private_settings = {
                        "language" : "en"
                    };
                    setValueForKey(currentUser.userId(), private_settings, data_key);
                }
            }

            return private_settings;
        };

    return {
        reset: function () {
            private_settings = {};
        },
        language: function () {
            var config = current_users_values();
            return config.language;
        },
        setLanguage: function (new_language) {

            private_settings["language"] = new_language;
            dump(private_settings);
            setValueForKey(currentUser.userId(), private_settings, data_key);
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
