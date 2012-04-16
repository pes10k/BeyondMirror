import "../"
import "../Panes"
import "../Controls"
import "../../JS/PXNotifications.js" as Notifications
import "../../JS/Controllers/PXPaneLanguage.js" as LanguageController
import QtQuick 1.1

PXWindow {

    // One of the following strings, describing which process the login window is going through:
    //  - "login" (a user just completed the login process, and now should see the "home screen")
    //  - "logout" (the user just finished their sesssion, and we're back at stage one)
    //  - "configure new user" (a user just signed in for the first time)
    //  - "configure new system" (this is the first time any user has used the mirror)
    property string currentState;
    property int temporaryUserId;

    // Implementation of "Notification Delegate Protocol"
    function receivedNotification (notification, params) {

        loginWindow.currentState = notification;

        switch (notification) {

            case "login":
                loginWindow.close();
                break;

            case "logout":
                setActivePane(loginPane);
                loginWindow.open();
                break;

            case "configure new user":
                setActivePane(languagePane);
                break;
        }
    }

    function setActivePane (pane) {

        var isLoginPane = pane === loginPane,
            isLanguagePane = pane === languagePane,
            isWifiPane = pane === wifiPane,
            isAccountPane = pane === accountPane;

        loginPane.visible = isLoginPane;
        languagePane.visible = isLanguagePane;
        wifiPane.visible = isWifiPane;
        accountPane.visible = isAccountPane;

        prevButton.visible = isWifiPane || isAccountPane;
        nextButton.visible = isWifiPane || isLanguagePane || isAccountPane;

        nextButton.textKey = isAccountPane ? "Yes" : "Next";

        if (isLoginPane) {
            loginText.textKey = "BeyondMirror";
        } else if (isLanguagePane) {
            loginText.textKey = "Select Language";
        } else if (isWifiPane) {
            loginText.textKey = "Network Settings";
        } else if (isAccountPane) {
            loginText.textKey = "Save Account?"
        }
    }

    Component.onCompleted: {
        Notifications.registry.registerForNotification(loginWindow, "login");
        Notifications.registry.registerForNotification(loginWindow, "logout");
        Notifications.registry.registerForNotification(loginWindow, "configure new user");
        Notifications.registry.registerForNotification(loginWindow, "configure new system");
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

        PXPaneAccount {
            id: accountPane
            anchors.fill: parent
            visible: false
        }
    }

    PXButtonImage {

        function onClick (button) {

            switch (loginWindow.currentState) {

                case "configure new user":
                    if (accountPane.visible) {
                        setActivePane(languagePane);
                    }
                    break;
            }
        }

        textKey: "Back"
        isBackButton: true
        id: prevButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
    }

    PXButtonImage {

        function onClick (button) {

            switch (loginWindow.currentState) {

                case "configure new user":

                    if (languagePane.visible) {
                        setActivePane(accountPane);
                    } else if (accountPane.visible) {
                        globalVariables.currentUserId = temporaryUserId;
                        LanguageController.languages.setLanguage(globalVariables.currentUserId, globalVariables.currentLangCode);
                        Notifications.registry.sendNotification("login", {"user_id" : globalVariables.currentUserId});
                    }
                    break;
            }
        }

        id: nextButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
    }
}
