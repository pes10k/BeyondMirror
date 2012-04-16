// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import "../"
import "../Controls"
import "../Rows"
import "../"
import "../../JS/Controllers/PXWindowHelp.js" as HelpController
import "../../JS/PXNotifications.js" as Notifications
import "../Controls"
import QtQuick 1.1

PXWindowDraggable {

    property string lastClickedTab: "news";

    // Implementation of "Array Result Delegate Protocol"
    function rowsForModel (model, modelIdentifier){

        if (modelIdentifier === "help list model") {

            HelpController.addHelpItemsToModel(model);
        }
    }

    // Implementation of "Notification Delegate Protocol"
    function receivedNotification (notification, params) {

        if (notification === "language changed") {
            helpWindow.updateHelpText();
        } else if (notification === "logout") {
            helpWindow.logout();
        } else if (notification === "login") {
            helpWindow.login();
        }
    }

    function updateHelpText () {

        var resolvedUrl = Qt.resolvedUrl("../../HTML/" + globalVariables.currentLangCode + "/help-" + helpWindow.lastClickedTab + ".html");
        helpWebView.url = resolvedUrl;
    }

    Component.onCompleted: {
        Notifications.registry.registerForNotification(helpWindow, "language changed");
        Notifications.registry.registerForNotification(helpWindow, "logout");
        helpWindow.updateHelpText();
    }

    Component.onDestruction: {
        Notifications.registry.unregisterForAll(helpWindow);
    }

    id: helpWindow
    titleKey: "Help"
    uniqueIdentifier: "help window"
    beginClosed: false

    contentView: Rectangle {
        color: "black"
        anchors.fill: parent

        PXListModelArray {
            color: "black"
            id: helpList
            width: (parent.width - 15) * .33

            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5

            modelIdentifier: "help list model"
            arrayResultDelegate: helpWidget
            viewComponent: Component {
                PXRowNext {
                    function mouseAreaEvent (mouseArea) {
                        helpWindow.lastClickedTab = rowTextKey.toLowerCase();
                        helpWindow.updateHelpText();
                    }
                }
            }
        }

        PXWebView {
            color: "white"
            id: helpWebView
            showProgressBar: false
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: helpList.right
            anchors.leftMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
        }
    }
}
