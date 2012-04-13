import "../../JS/PXApp.js" as App
import "../../JS/PXNotifications.js" as Notifications
import "../"
import QtQuick 1.1

PXRowNext {

    function mouseAreaEvent () {
        Notifications.registry.sendNotification("request for window", {
            "window" : "twitter window",
            "params" : {
                "title" : rowTwitterUser,
                "url" : rowTwitterUrl
            }
        });
    }
}
