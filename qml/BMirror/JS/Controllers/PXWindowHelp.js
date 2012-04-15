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
