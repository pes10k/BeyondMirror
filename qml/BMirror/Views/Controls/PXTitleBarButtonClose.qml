import "../Controls"
import QtQuick 1.1

PXTitleBarButton {
    id: titleBarButtonClose

    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectCrop
        source: "../../Images/delete-icon.png"
    }
}
