// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {

    function hide () {
        pane.visible = false;
    }

    function show () {
        pane.visible = true;
    }

    id: pane
    radius: 5
    border.color: "#000000"
    anchors.fill: parent
}
