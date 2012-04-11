import "../../JS/Controllers/PXWidgetStocks.js" as StocksController
import "../"
import QtQuick 1.1

PXWindowWidget {

    // Implementation of the "Array List Model Delegate Protocol"
    function rowsForModel (model, modelIdentifier) {

        for (var i = 0; i < 4; i++) {

            model.append({"index" : i});
        }
    }

    titleKey: "Stocks"
    id: stocksWidget

    contentView: PXListModelArray {
        modelIdentifier: "stocks model"
        arrayResultDelegate: stocksWidget

    }
}
