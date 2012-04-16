import "../"
import "../Panes"
import "../../JS/PXNotifications.js" as Notifications
import QtQuick 1.1

PXWindow {

    // Implementation of "Notification Delegate Protocol"
    function receivedNotification (notification, params) {
        if (notification === "login") {
            loginWindow.close();
        } else if (notification === "logout") {
            loginWindow.open();
        }
    }

    Component.onCompleted: {
        Notifications.registry.registerForNotification(loginWindow, "login");
        Notifications.registry.registerForNotification(loginWindow, "logout");
    }

    Component.onDestruction: {
        Notifications.registry.unregisterForAll(loginWindow);
    }


    id: loginWindow

    PXText {
        id: loginText
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 56
        lineHeight: 56
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: paneContainer.top
        anchors.bottomMargin: 10
        textKey: "BeyondMirror"

    }

    Rectangle {
        id: paneContainer

        color: "transparent"
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 120
        anchors.fill: parent

        PXPaneLogin {
            anchors.fill: parent
            id: loginPane
        }
    }
}
