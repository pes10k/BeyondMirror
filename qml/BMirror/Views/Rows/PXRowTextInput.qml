import "../Controls"
import QtQuick 1.1

/**
 * "Row Text Input Delegate Protocol"
 * ====
 *
 * - rowTextInputClicked (rowTextInput)
 *   This function will be called on the delegate whenever the user clicks on the
 *   "+" button next to the text input in this row.
 */
Rectangle {

    // Reference to an element that implements the "Row Text Input Delegate Protocol",
    // defined above.
    property variant rowTextInputDelgate;

    // A string, uniquely defining this row text input across the entire application
    property string rowTextInputIdentifier;

    // Returns the current text entered into the text input
    function text () {
        return textInput.text();
    }

    // Clears out the text entered in the text input.
    function clear () {
        return textInput.clear();
    }

    id: textInputRow
    width: parent.width
    height: 50

    Rectangle {
        id: addButton
        width: height
        color: "#000000"
        radius: 20
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5

        MouseArea {
            id: mouseArea
            anchors.fill: parent

            onClicked: {
                if (textInputRow.rowTextInputDelgate) {
                    textInputRow.rowTextInputDelgate.rowTextInputClicked(textInputRow);
                }
            }

            Rectangle {
                id: plusSignVertical
                width: 200
                height: parent.height * .2
                color: "#ffffff"
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.left: parent.left
            }

            Rectangle {
                id: plusSignHorizontal
                width: parent.width * .2
                color: "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 5
            }
        }
    }

    PXTextEdit {
        id: textInput
        border.width: 1
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: addButton.left
        anchors.rightMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 5
    }
}
