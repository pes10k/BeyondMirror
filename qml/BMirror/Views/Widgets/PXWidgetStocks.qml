import "../../JS/PXApp.js" as App
import "../../JS/Controllers/PXController.js" as GenericController
import "../../JS/PXNotifications.js" as Notifications
import "../../JS/Controllers/PXWidgetStocks.js" as StocksController
import "../../Views/Rows"
import "../Controls"
import "../"
import QtQuick 1.1

PXWindowWidget {

    // Implementation of the "Row Text Input Delegate Protocol"
    function rowTextInputClicked (rowTextInput) {

        if (rowTextInput.rowTextInputIdentifier === "stocks text input") {

            StocksController.stocks.addStock(globalVariables.currentUserId, rowTextInput.text(), function (isSuccess) {

                if (!isSuccess) {

                    stocksEditSheet.setFeedback("Invalid Stock!", 2000, true);

                } else {

                    stocksEditSheet.modelArray().refresh();
                    stocksViewModel.refresh();
                    rowTextInput.clear();
                }
            });
        }
    }

    // Implementation of the "Array List Model Delegate Protocol"
    function rowsForModel (model, modelIdentifier) {

        switch (modelIdentifier) {

        case "stocks view model":
        case "stocks config model":
            StocksController.addCurrentUsersStocksToModel(globalVariables.currentUserId, model, modelIdentifier);
            break;
        }
    }

    // Implementation of "Notification Delegate Protocol"
    function receivedNotification (notification, params) {

        if (notification === "edit row delete clicked") {

            if (params.modelIdentifier == "stocks config model") {

                GenericController.removeRowFromModel(
                    params.row,
                    stocksEditSheet.modelArray().getViewModel(),
                    stocksEditSheet.modelArray(),
                    function () {
                        StocksController.stocks.removeStock(globalVariables.currentUserId, params.row.identifier());
                        stocksEditSheet.modelArray().refresh();
                        stocksViewModel.refresh();
                    }
                );
            }
        }
    }

    Component.onCompleted: {
        Notifications.registry.registerForNotification(stocksWidget, "edit row delete clicked");
    }

    Component.onDestruction: {
        Notifications.registry.unregisterForAll(stocksWidget);
    }

    titleKey: "Stocks"
    id: stocksWidget

    configurationView: PXEditableSheet {
        id: stocksEditSheet
        rowTextInputTextKey: "Add additional stock:"
        rowTextInputDelgate: stocksWidget
        rowTextInputIdentifier: "stocks text input"
        modelIdentifier: "stocks config model"
        arrayResultDelegate: stocksWidget
        viewComponent: Component {
            PXRowTextEdit {}
        }
    }

    contentView: PXListModelArray {
        id: stocksViewModel
        modelIdentifier: "stocks view model"
        arrayResultDelegate: stocksWidget
        viewComponent: Component {
            Rectangle {
                width: parent.width
                height: 50
                color: "white"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Notifications.registry.sendNotification("request for window", {
                            "window" : "stock window",
                            "params" : {
                                "call_letters" : rowTextKey,
                                "name" : rowStockName
                            }
                        });
                    }
                }

                PXText {
                    id: stockNameLabel
                    color: "black"
                    textKey: rowTextKey
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width - stockValueLabel.width - nextImage.width - 15
                }

                PXText {
                    color: "black"
                    textKey: rowStockValue
                    id: stockValueLabel
                    width: 60
                    horizontalAlignment: Text.AlignRight
                    anchors.right: nextImage.left
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                }

                Image {
                    id: nextImage
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    width: 22
                    height: 18
                    anchors.verticalCenter: parent.verticalCenter
                    source: "../../Images/forward-icon.png"
                }

                Rectangle {
                    color: "black"
                    height: 1
                    width: parent.width
                    anchors.bottom: parent.bottom
                }
            }
        }
    }
}
