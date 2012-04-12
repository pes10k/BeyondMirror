import "../"
import QtQuick 1.1

Rectangle {
    width: parent.width
    height: 50
    color: "white"

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log(rowTextKey + " was clicked");
        }
    }

    PXText {
        id: stockNameLabel
        color: "black"
        textKey: rowTextKey
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width - 60
    }

    PXText {
        color: "black"
        textKey: rowStockValue
        id: stockValueLabel
        width: 60
        horizontalAlignment: Text.AlignRight
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }
}
