import "../"
import "../Panes"
import "../Controls"
import "../../JS/PXNotifications.js" as Notifications
import QtQuick 1.1

PXWindow {

    // Implementation of "Notification Delegate Protocol"
    function receivedNotification (notification, params) {

        switch (notification) {

            case "login":
                loginWindow.close();
                break;

            case "logout":
                loginText.textKey = "BeyondMirror";
                setActivePane(loginPane);
                loginWindow.open();
                break;

            case "configure new user":
                loginText.textKey = "Select Language";
                setActivePane(languagePane);
                break;
        }
    }

    function setActivePane (pane) {

        var isLoginPane = pane === loginPane,
            isLanguagePane = pane === languagePane,
            isWifiPane = pane === wifiPane;

        loginPane.visible = isLoginPane;
        languagePane.visible = isLanguagePane;
        wifiPane.visible = isWifiPane;

        prevButton.visible = isWifiPane;
        nextButton.visible = isWifiPane || isLanguagePane;
    }

    Component.onCompleted: {
        Notifications.registry.registerForNotification(loginWindow, "login");
        Notifications.registry.registerForNotification(loginWindow, "logout");
        Notifications.registry.registerForNotification(loginWindow, "configure new user");
        Notifications.registry.registerForNotification(loginWindow, "configure system user");
        receivedNotification("logout");
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

        PXPaneLanguage {
            anchors.fill: parent
            id: languagePane
            visible: false
        }

        PXPaneWifi {
            anchors.fill: parent
            id: wifiPane
            visible: false
        }
    }

    PXButtonImage {
        textKey: "Back"
        isBackButton: true
        id: prevButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
    }

    PXButtonImage {
        id: nextButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
    }
}
