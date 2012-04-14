import "../../JS/PXApp.js" as App
import "../"
import Qt 4.7
import QtQuick 1.1

PXWindowDraggable {

    function setParams (params) {

        videoWindow.titleKey = params.title;
        video.source = params.source;
    }

    id: videoWindow
    uniqueIdentifier: "video window draggable"

    contentView: Rectangle {
        id: contentView
        color: "black"
        anchors.fill: parent

        Image {
            anchors.top: parent.top
            id:video
            height: parent.height*0.9
            width:  parent.width
        }

        Image{
            id:player
            source:"../../Images/player.png"
            height:parent.height*0.1
            width: parent.width
            anchors.top: video.bottom
        }
    }
}
