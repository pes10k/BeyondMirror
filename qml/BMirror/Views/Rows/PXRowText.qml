import "../"
import QtQuick 1.1

Rectangle {

    id: row
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
        id: label
        color: "black"
        textKey: rowTextKey
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }
}
