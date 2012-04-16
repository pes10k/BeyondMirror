import "../"
import QtQuick 1.1

Rectangle {

    function text () {
        return textElement.text;
    }

    function clear () {
        textElement.text = "";
    }

    function setFeedback (message, duration, isError) {

        feedbackTimer.interval = duration;
        feedbackText.textKey = message
        feedbackText.color = isError ? "red" : "green"
        textElement.visible = false;
        feedbackTimer.start();
    }

    Timer {
        id: feedbackTimer
        interval: 500;
        running: false;
        repeat: false;
        onTriggered: {
            textElement.visible = true;
        }
    }

    id: addTextContainer
    color: "#ffffff"
    border.width: 1
    border.color: "#000000"

    PXText {
        id: feedbackText
        height: textElement.height
        width: textElement.width
        visible: !textElement.visible
        anchors.horizontalCenter: parent.horizontalCenter
    }

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
