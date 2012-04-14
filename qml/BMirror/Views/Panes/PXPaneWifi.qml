import "../"
import "../Controls"
import "../Rows"
import "../../JS/PXNotifications.js" as Notifications
import "../../JS/PXApp.js" as App
import QtQuick 1.1

PXPane {
    id: networkPane
    width: 100
    height: 62

    PXText {
        id: networkLabel
        width: (parent.width - 20) * .5
        height: 30
        color: "#000000"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        textKey: "Select Network"
    }

    PXListModelArray {
        id: wifiListModel
        width: (parent.width - 30) * .5
        anchors.top: networkLabel.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: otherNetworkLabel.top
        anchors.bottomMargin: 15
    }

    PXText {
        id: otherNetworkLabel
        textKey: "Other Network Name"
        color: "black"
        anchors.bottom: otherNetworkInput.top
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: (parent.width - 30) * .5
    }

    PXTextEdit {
        id: otherNetworkInput
        height: 30
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: (parent.width - 30) * .5
    }


    PXText {
        id: securityLabel
        width: (parent.width - 20) * .5
        height: 30
        color: "#000000"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        textKey: "Security Type"
    }

    PXListModelArray {
        id: securityListModel
        width: (parent.width - 30)* .5
        anchors.bottom: passwordLabel.top
        anchors.bottomMargin: 15
        anchors.top: securityLabel.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 10
    }

    PXText {
        id: passwordLabel
        textKey: "Network Password"
        color: "black"
        anchors.bottom: paswordInput.top
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        width: (parent.width - 30) * .5
    }

    PXTextEdit {
        id: paswordInput
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: (parent.width - 30) * .5
    }
}
