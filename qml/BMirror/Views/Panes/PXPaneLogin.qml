import "../"
import "../Controls"
import "../Rows"
import "../../JS/PXNotifications.js" as Notifications
import "../../JS/PXApp.js" as App
import "../../JS/PXStorage.js" as Storage
import QtQuick 1.1

PXPane {

    property int imagePositionIndex: 0;

    id: loginPane
    anchors.fill: parent

    Timer {
        id: fingerTimer
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            fingerImage.anchors.topMargin = (loginPane.height - fingerImage.height) * .1 * (imagePositionIndex++ % 11)
        }
    }

    Rectangle {
        id: scannerTop
        width: 200
        height: 20
        color: "#d3d3d3"
        border.width: 2
        border.color: "#000000"
        anchors.verticalCenterOffset: -50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle {
        id: scannerBottom
        width: 200
        height: 20
        color: "#bebebe"
        border.width: 2
        anchors.top: scannerTop.bottom
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: "#000000"
    }

    Image {
        id: fingerImage
        width: 92
        height: 176
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        source: "../../Images/finger.png"
    }

    PXText {
        id: fingerPrintLabel
        width: 140
        height: 54
        color: "#000000"
        horizontalAlignment: Text.AlignRight
        textKey: "Fingerprint input:"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
    }

    PXTextEdit {
        id: fingerPrintInput
        width: 120
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: fingerPrintLabel.bottom
        anchors.topMargin: 10
        border.color: "#000000"
    }

    PXButtonImage {
        id: loginButton
        width: 120
        anchors.top: fingerPrintInput.bottom
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

        function onClick (button) {

            var possibleUserId = parseInt(fingerPrintInput.text(), 10);

            if (fingerPrintInput.text() && possibleUserId == fingerPrintInput.text()) {

                Storage.dataExistsForUser(possibleUserId, function (user_exists) {

                    feedBackText.textKey = "";
                    fingerPrintInput.clear();

                    // If the given user ID exists, then we're all done, and can
                    // fastforward past the setup process and just jump to the application.
                    if (user_exists) {

                        globalVariables.currentUserId = possibleUserId;
                        Notifications.registry.sendNotification("login", {"user_id" : possibleUserId});

                    } else {

                        // Next, check to see if there is any data stored for any users in the system.
                        // If there isn't we need to go through a full config process, including
                        // setting up the wifi.
                        Storage.dataExistsForAnyUser(function (dataExists) {

                            temporaryUserId = possibleUserId;
                            globalVariables.currentUserId = -1;
                            globalVariables.currentLangCode = "en";

                            if (dataExists) {

                                languagePane.model().refresh();
                                Notifications.registry.sendNotification("configure new user", {"user_id" : globalVariables.currentUserId});

                            } else {

                                Notifications.registry.sendNotification("configure system", {"user_id" : globalVariables.currentUserId});

                            }
                        });
                    }
                });

            } else {

                feedBackText.textKey = "Users must be integers"

            }
        }
    }

    PXText {
        id: feedBackText
        width: 120
        height: 52
        color: "#ff0000"
        anchors.top: loginButton.bottom
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
    }
}
