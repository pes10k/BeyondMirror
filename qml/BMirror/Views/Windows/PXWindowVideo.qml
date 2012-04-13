import "../../JS/PXApp.js" as App
import "../"
import Qt 4.7
import QtQuick 1.1

PXWindowDraggable {

    function setParams (params) {

        videoWindow.titleKey = params.title;
        //videoPlayer.source = params.source;
    }

    id: videoWindow
    uniqueIdentifier: "video window draggable"

    contentView: Rectangle {
        id: contentView
        color: "black"
        anchors.fill: parent
//        Video {
//            id: videoPlayer
//            source: ""
//            anchors.fill: parent
//        }
    }
}
