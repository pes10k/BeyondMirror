import "../../JS/Controllers/PXWidgetStocks.js" as StocksController
import "../../Views/Rows"
import "../"
import QtQuick 1.1

PXWindowWidget {

    // Implementation of the "Array List Model Delegate Protocol"
    function rowsForModel (model, modelIdentifier) {

        var users_stocks = StocksController.stocks.currentStocks(),
                i = 0;

        for (i; i < users_stocks.length; i++) {

            StocksController.stockFetcher(users_stocks[i], function (result) {

                                              model.append({
                                                               "rowTextKey" : result.name,
                                                               "rowStockValue" : result.value
                                                           });

                                          });
        }
    }

    titleKey: "Stocks"
    id: stocksWidget

    contentView: PXListModelArray {

        modelIdentifier: "stocks model"
        arrayResultDelegate: stocksWidget
        viewComponent: Component {
            Rectangle {
                width: parent.width
                height: 50
                color: "white"

                MouseArea {

                    anchors.fill: parent
                    onClicked: {
                        console.log(rowTextKey + " was clicked");
                    }
                }

                PXText {
                    id: stockNameLabel
                    color: "black"
                    textKey: rowTextKey
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width - 60
                }

                PXText {
                    color: "black"
                    textKey: rowStockValue
                    id: stockValueLabel
                    width: 60
                    horizontalAlignment: Text.AlignRight
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
