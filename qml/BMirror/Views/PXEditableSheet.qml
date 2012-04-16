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

    property bool isDisplayingFeedback: false;
    property color feedbackColor;
    property string feedbackTextKey;
    property string prevFeedbackTextKey;

    function modelArray () {
        return arrayListModel;
    }

    function editRow () {
        return editRow;
    }

    function setFeedback (message, duration, isError) {

        feedbackTimer.interval = duration;
        editSheet.feedbackTextKey = message
        editSheet.feedbackColor = isError ? Qt.rgba(255, 0, 0, 1) : Qt.rgba(0, 0, 0, 1);
        editSheet.isDisplayingFeedback = true
        feedbackTimer.start();
    }

    onIsDisplayingFeedbackChanged: {

        if (editSheet.isDisplayingFeedback) {

            editSheet.prevFeedbackTextKey = newSectionLabel.textKey;
            newSectionLabel.textKey = editSheet.feedbackTextKey;
            newSectionLabel.color = editSheet.feedbackColor;

        } else {

            newSectionLabel.textKey = editSheet.prevFeedbackTextKey;
            newSectionLabel.color = Qt.rgba(0, 0, 0, 1);

        }
    }

    id: editSheet
    anchors.fill: parent
    color: "white"

    Timer {
        id: feedbackTimer
        interval: 500;
        running: false;
        repeat: false;
        onTriggered: {
            isDisplayingFeedback = false
        }
    }

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
        textKey: isDisplayingFeedback ? newSectionLabel.feedbackText : newSectionLabel.textKey
        id: newSectionLabel
        anchors.bottom: editRow.top
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        color: isDisplayingFeedback ? newSectionLabel.feedbackColor : "black"
        height: parent.height > 30 ? 30 : parent.height
        visible: parent.height > 40
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
