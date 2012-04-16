import "../Views/Controls"
import "../Views/Rows"
import QtQuick 1.1

Rectangle {

    property string modelIdentifier;
    property variant arrayResultDelegate;
    property variant viewComponent;

    property alias textInput: editRow.textInput
    property alias rowTextInputTextKey: newSectionLabel.textKey;
    property variant rowTextInputDelgate;
    property string rowTextInputIdentifier;

    function modelArray () {
        return arrayListModel;
    }

    function editRow () {
        return editRow;
    }

    function setFeedback (message, duration, isError) {

        feedbackTimer.interval = duration;
        feedbackText.textKey = message
        feedbackText.color = isError ? "red" : "green"
        editRow.visible = false;
        feedbackTimer.start();
    }

    Timer {
        id: feedbackTimer
        interval: 500;
        running: false;
        repeat: false;
        onTriggered: {
            editRow.visible = true;
        }
    }

    id: editSheet
    anchors.fill: parent
    color: "white"

    PXListModelArray {

        modelIdentifier: editSheet.modelIdentifier
        arrayResultDelegate: editSheet.arrayResultDelegate
        viewComponent: editSheet.viewComponent

        id: arrayListModel
        anchors.bottom: seperator.top
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }

    Rectangle {
        id: seperator
        height: 1
        color: "#000000"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: newSectionLabel.top
        anchors.bottomMargin: 5
        visible: parent.height > 10
    }

    PXText {
        id: newSectionLabel
        anchors.bottom: editRow.top
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        color: "black"
        height: parent.height > 30 ? 30 : parent.height
        visible: parent.height > 40
    }

    PXText {
        id: feedbackText
        height: editRow.height
        width: editRow.width
        visible: !editRow.visible
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5

        verticalAlignment: Text.AlignVCenter
    }

    PXRowTextInput {

        rowTextInputDelgate: editSheet.rowTextInputDelgate
        rowTextInputIdentifier: editSheet.rowTextInputIdentifier

        id: editRow
        height: parent.height < 50 ? parent.height : 50
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }
}
