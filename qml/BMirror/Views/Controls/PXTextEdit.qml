// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {

    function text () {
        return textElement.text;
    }

    function clear () {
        textElement.text = "";
    }

    id: addTextContainer
    color: "#ffffff"

    border.width: 1
    border.color: "#000000"

    TextEdit {

        id: textElement
        font.family: "Futura"
        font.pixelSize: 20
        wrapMode: TextEdit.NoWrap;
        verticalAlignment: Text.AlignVCenter;
        horizontalAlignment: Text.AlignLeft;
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height >= 30 ? parent.height : 0
        width: parent.width - 10
        visible: textElement.height >= 30
    }
}
