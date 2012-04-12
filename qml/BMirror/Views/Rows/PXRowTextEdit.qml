import "../../JS/PXApp.js" as App
import "../../JS/PXNotifications.js" as Notifications
import QtQuick 1.1

PXRowText {
    id: editRow

    Rectangle {
        id: deleteButton
        width: height
        color: "#000000"
        radius: 20
        border.color: "#000000"
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5

        MouseArea {
            anchors.fill: parent
            onClicked: {
                var params = {
                    "row" : editRow,
                    "rowTextKey" : rowTextKey,
                    "modelIdentifier" : modelIdentifier
                };

                Notifications.registry.sendNotification("edit row delete clicked", params);
            }
        }

        Rectangle {
            id: minusSign
            width: parent.width * .75
            height: parent.height * .2
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
