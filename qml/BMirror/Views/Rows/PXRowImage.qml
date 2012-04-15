// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

PXRowText {

    id: row

    Image {
        id: image
        width: height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        source: rowImageUrl
    }
}
