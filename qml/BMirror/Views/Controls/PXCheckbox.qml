import "../"
import QtQuick 1.1

/**
 * "Checkbox Delegate Protocol"
 *
 * - checkboxClicked (checkbox)
 */
Rectangle {

    function checked (shouldBeChecked) {
        checkbox.isChecked = shouldBeChecked
    }

    // True if the checkbox should appear "checked", otherwise false
    property bool isChecked

    // Text identifier for the checkbox, which can be used to identify different
    // instances of the checkbox throughout the application
    property string textboxIndentifier

    // The untranslated version of the label that should appear next to
    // the checkbox
    property string textKey

    // Reference to an object that implements the "Checkbox Delegate Protocol",
    // defined above
    property variant checkboxDelegate

    Component.onCompleted: {
        image.source = checkbox.isChecked ? "../../Images/box-checked.png" : "../../Images/box-unchecked.png";
    }

    onIsCheckedChanged: {
        image.source = checkbox.isChecked ? "../../Images/box-checked.png" : "../../Images/box-unchecked.png";
    }

    id: checkbox

    Image {
        height: parent.height < 48 ? parent.height : 48
        id: image
        visible: parent.height > 10
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.verticalCenter: parent.verticalCenter
        source: "../../Images/box-unchecked.png"
    }

    PXText {

        id: label
        visible: parent.height > 10
        textKey: checkbox.textKey
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: image.right
        anchors.leftMargin: 5
        maximumLineCount: 1
        color: "black"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (checkbox.checkboxDelegate) {
                checkbox.checkboxDelegate.checkboxClicked(checkbox)
            }
        }
    }
}
