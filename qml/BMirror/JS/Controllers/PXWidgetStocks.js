Qt.include("../PXStorage.js");
Qt.include("../PXUser.js");

var stocks = function () {

    var data_key = "followed stocks",
            default_value,
            current_stocks = valueForKey(currentUser.userId(), data_key);

    // If we don't have any stocks set (such as the first time we've opened
    // up the widget) create some sensable defaults.
    if (!current_stocks) {

        default_value = ["AAPL"];
        setValueForKey(currentUser.userId(), default_value, data_key);
        current_stocks = default_value;
    }

    return {
        currentStocks: function () {
            return current_stocks;
        }
    };
}
