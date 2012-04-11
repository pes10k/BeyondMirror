import "../../JS/Controllers/PXWidgetStocks.js" as StocksController
import "../../Views/Rows"
import "../"
import QtQuick 1.1

PXWindowWidget {

    // Implementation of the "Array List Model Delegate Protocol"
    function rowsForModel (model, modelIdentifier) {
        console.log("HERE");
        for (var i = 0; i < 4; i++) {
            console.log(i)
            model.append({"textKey" : i});
        }
    }

    titleKey: "Stocks"
    id: stocksWidget

    contentView: PXListModelArray {
        modelIdentifier: "stocks model"
        arrayResultDelegate: stocksWidget
        viewComponent: Component {
            PXRowText {}
        }
    }
}
