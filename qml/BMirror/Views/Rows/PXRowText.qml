import "../"
import QtQuick 1.1

Rectangle {

    // Returns a string that (should) uniquely identifiy a row in a list
    // view.
    function identifier () {
        return rowTextKey;
    }

    function textLabel () {
        return label;
    }

    function mouseArea () {
        return mouseArea;
    }

    id: row
    width: parent.width
    height: 50
    color: "white"

    MouseArea {

        id: mouseArea
        anchors.fill: parent
        onClicked: {

            // Allow "subclasses" to programatically set custom events
            // for the mousearea tap
            if (row.mouseAreaEvent) {

                row.mouseAreaEvent(mouseArea);

            } else {

                console.log(rowTextKey + " was clicked");
            }
        }
    }

    PXText {
        id: label
        color: "black"
        textKey: rowTextKey ? rowTextKey : ""
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        elide: Text.ElideRight
    }

    Rectangle {
        color: "black"
        height: 1
        width: parent.width
        anchors.bottom: parent.bottom
    }
}
