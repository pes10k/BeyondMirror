import "../"
import "../Rows"
import "../../JS/PXNotifications.js" as Notifications
import "../../JS/PXApp.js" as App
import QtQuick 1.1

Rectangle {
    id: networkPane
    width: 100
    height: 62

    PXText {
        id: networkLabel
        width: (parent.width - 20) * .5
        height: 30
        color: "#000000"
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        textKey: "Select Network"
    }

    PXListModelArray {
        id: wifiListModel
        width: (parent.width - 30)* .5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.top: networkLabel.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    PXText {
        id: securityLabel
        width: (parent.width - 20) * .5
        height: 30
        color: "#000000"
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        textKey: "Security Type"
    }

    PXListModelArray {
        id: securityListModel
        width: (parent.width - 30)* .5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.top: securityLabel.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 10
    }
}
