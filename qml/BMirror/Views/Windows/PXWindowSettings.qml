import "../../JS/PXApp.js" as App
import "../Controls"
import "../Panes"
import "../"
import QtQuick 1.1

PXWindowDraggable {

    // Implementation of "Tab Delegate Protocol"
    function tabItemClicked (tabElement) {

        // If the tab being clicked is active, do nothing,
        // since nothing has changed
            if (tabElement === wifiTab) {

                wifiTab.setActiveState(true);
                languageTab.setActiveState(false);
                wifiPane.show();
                languagePane.hide();

            } else {

                wifiTab.setActiveState(false);
                languageTab.setActiveState(true);
                wifiPane.hide();
                languagePane.show();

            }
    }

    id: settingsWindow
    uniqueIdentifier: "settings window"
    titleKey: "Settings"
    beginClosed: false

    contentView: Rectangle {

        id: contentContainer
        color: "transparent"
        anchors.fill: parent

        PXTab {
            id: languageTab
            anchors.left: parent.left
            anchors.leftMargin: ((parent.width * .5) - width) * .66
            textKey: "Language"
            tabIdentifier: "settings language tab"
            tabDelegate: settingsWindow
            state: "ABLED"
        }

        PXTab {
            anchors.right: parent.right
            anchors.rightMargin: ((parent.width * .5) - width) * .66
            id: wifiTab
            textKey: "WiFi"
            tabIdentifier: "wifi language tab"
            tabDelegate: settingsWindow
            state: "DISABLED"
        }

        Rectangle {
            id: paneContainer
            color: "transparent"
            anchors.top: languageTab.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 0

            PXPaneLanguage {
                id: languagePane
                border.width: 0
                anchors.fill: parent
                visible: true
            }

            PXPaneWifi {
                id: wifiPane
                border.width: 0
                anchors.fill: parent
                visible: false
            }
        }
    }
}
