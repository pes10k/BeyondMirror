import "../../JS/PXApp.js" as App
import "../../JS/Controllers/PXController.js" as GenericController
import "../../JS/PXNotifications.js" as Notifications
import "../../Views/Rows"
import "../Controls"
import "../"
import QtQuick 1.1

PXWindowWidget {

    Component.onCompleted: {
        Notifications.registry.registerForNotification(newsWidget, "edit row delete clicked");
    }

    Component.onDestruction: {
        Notifications.registry.unregisterForAll(newsWidget);
    }

    titleKey: "News"
    id: newsWidget

    contentView: Rectangle {
        color: "#ff0000"
        anchors.fill: parent;
        width: 200
        height: 100
    }
}
