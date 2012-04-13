Qt.include("../PXApp.js");
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
                      "call_letters" : call_letters,
                      "name" : result[0].t,
                      "value" : result[0].l,
                      "full_name" : result[0].name,
                      "direction" : (parseInt(result[0].c, 10) > 0) ? "up" : "down"
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
        reset: function () {
            current_stocks = valueForKey(currentUser.userId(), data_key);
        },
        currentStocks: function () {
            return current_stocks;
        },
        addStock: function (new_stock, callback) {

            new_stock = new_stock.toUpperCase();

            // First, check to make sure that the stock we're trying
            // to add doesn't already exist in the list of stocks
            // being watched.
            if (current_stocks.indexOf(new_stock) !== -1) {

                return false;

            } else {

                // Next, make sure that the given stock is a valid one
                stockFetcher(new_stock, function (result) {

                    if ( ! result) {

                        callback(false);

                    } else {

                        current_stocks.push(new_stock);
                        setValueForKey(currentUser.userId(), current_stocks, data_key, callback);
                    }
                });
            }
        },
        removeStock: function (call_letters, callback) {

            var adjusted_stocks = removeFromArray(call_letters, current_stocks);

            if (adjusted_stocks) {

                current_stocks = adjusted_stocks;
                setValueForKey(currentUser.userId(), current_stocks, data_key, callback);
                return true;

            } else {

                return false;
            }
        }
    };
}());

var addCurrentUsersStocksToModel = function (model, modelIdentifier) {

    var users_stocks = stocks.currentStocks(),
            i = 0;

    for (i; i < users_stocks.length; i++) {

        stockFetcher(users_stocks[i], function (result) {

            model.append({
                "rowTextKey" : result.name,
                "rowStockValue" : result.value,
                "rowStockName" : result.full_name,
                "modelIdentifier" : modelIdentifier
            });
        });
    }
}
