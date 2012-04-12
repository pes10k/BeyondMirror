import "../Views/Controls"
import "../Views/Rows"
import QtQuick 1.1

Rectangle {

    property string modelIdentifier;
    property variant arrayResultDelegate;
    property variant viewComponent;

    property variant rowTextInputDelgate;
    property string rowTextInputIdentifier;

    function modelArray () {
        return arrayListModel;
    }

    function editRow () {
        return editRow;
    }

    id: editSheet
    width: parent.width
    height: parent.height

    PXListModelArray {

        modelIdentifier: editSheet.modelIdentifier
        arrayResultDelegate: editSheet.arrayResultDelegate
        viewComponent: editSheet.viewComponent

        id: arrayListModel
        anchors.bottom: editRow.top
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
        anchors.bottom: editRow.top
        anchors.bottomMargin: 0
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
