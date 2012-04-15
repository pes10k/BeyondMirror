var addHelpItemsToModel = function (model) {

    var i = 0,
        rows = [
        "News",
        "Twitter",
        "Stocks",
        "Health",
        "Video",
        "Clock",
        "Weather",
        "Settings"
    ];

    for (i; i < rows.length; i++) {

        model.append({"rowTextKey" : rows[i]});
    }
};

//var helpTextForLanguage = (function () {

//    var cache = {},
//        reader = new StreamReader(),
//        current_line;

//    return function (help_type, language_code) {

//        var file_contents = ''  ;

//        help_type = help_type.toLowerCase();
//        language_code = language_code.toLowerCase();

//        if (cache[language_code] && cache[language_code][help_type]) {

//            file_contents = cache[language_code][help_type];

//        } else {

//            reader.open("../../HTML/" + language_code + "/help-" + help_type + ".html");
//            while (file_contents = reader.)
//        }
//    };
//}());
