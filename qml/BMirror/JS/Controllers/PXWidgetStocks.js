Qt.include("../PXStorage.js");
Qt.include("../PXUser.js");
Qt.include("../PXJSONFetcher.js");

var stockFetcher = (function () {

  var cached_data = {};

  return function (call_letters, callback) {

      if (cached_data[call_letters]) {

          callback(cached_data[call_letters]);

      } else {

          fetcher.get("http://www.google.com/finance/info?infotype=infoquoteall&q=" + call_letters, function (result, url) {

              if (result.length == 0) {

                  callback(false);

              } else {

                  cached_data[call_letters] = {
                      "name" : result[0].t,
                      "value" : result[0].l,
                      "direction" : (parseInt(result[0].c, 10) > 0) ? "up" : "down"
                  }

                  for (var key in cached_data[call_letters]) {
                      console.log("key (" + key + ") = " + cached_data[call_letters][key]);
                  }

                  callback(cached_data[call_letters]);
              }
          });
      }
  };
}());

var stocks = (function () {

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
        },
        addStock: function (newStock) {
            current_stocks.push(newStock);
            setValueForKey(currentUser.userId(), current_stocks, data_key);
        }
    };
}());
