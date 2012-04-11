import "../"
import QtQuick 1.1

Rectangle {

    property string textKey;

    id: row
    width: parent.width
    height: 50
    color: "white"

    MouseArea {

        anchors.fill: parent
        onClicked: {
            console.log(textKey + " was clicked");
        }
    }

    PXText {
        id: label
        color: "#000000"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }
}
