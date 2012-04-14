import "../"
import "../Rows"
import "../../JS/Controllers/PXPaneLanguage.js" as LanguageController
import "../../JS/PXNotifications.js" as Notifications
import "../../JS/PXApp.js" as App
import QtQuick 1.1

PXPane {

    // Implementation of "Array List Model Delegate Protocol"
    function rowsForModel (model, modelIdentifier) {

        var current_index = -1;

        if (modelIdentifier === "language selection pane") {

            LanguageController.addLanguagesToModel(model);

            current_index = languagePane.updateCheckmarks(LanguageController.languages.language());
            lanugageListView.getListView().positionViewAtIndex(current_index, ListView.Center);
        }
    }

    function updateCheckmarks (currentCode) {

        var row,
            i = 0,
            index = -1,
            listModel = lanugageListView.getViewModel(),
            isCurrent = false;

        for (i; i < listModel.count; i++) {

            row = listModel.get(i);
            row.isCurrent = row.rowLanguageCode === currentCode;

            if (row.isCurrent) {
                index = i;
            }
        }

        return index;
    }

    id: languagePane

    PXListModelArray {

        id: lanugageListView
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: 280

        modelIdentifier: "language selection pane"
        arrayResultDelegate: languagePane
        viewComponent: Component {
            PXRowLanguage {
                function mouseAreaEvent (mouseArea) {
                    LanguageController.languages.setLanguage(rowLanguageCode);
                    Notifications.registry.sendNotification("language changed", {"code" : rowLanguageCode});
                    languagePane.updateCheckmarks(rowLanguageCode);
                }
            }
        }
    }
}
