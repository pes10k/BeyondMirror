import "../../JS/PXApp.js" as App
import "../../JS/Controllers/PXWidgetNews.js" as NewsController
import "../../JS/Controllers/PXController.js" as GenericController
import "../../JS/PXNotifications.js" as Notifications
import "../../Views/Rows"
import "../Controls"
import "../"
import QtQuick 1.1

PXWindowWidget {

    // Implementation of the "Array List Model Delegate Protocol"
    function rowsForModel (model, modelIdentifier) {

        if (modelIdentifier === "news view model") {
            NewsController.addCurrentUsersNewsItemsToModel(model);
        } else if (modelIdentifier === "news config model") {
            NewsController.addCurrentUsersNewsFeedsToModel(model);
        }
    }

    Component.onCompleted: {
        Notifications.registry.registerForNotification(newsWidget, "edit row delete clicked");
    }

    Component.onDestruction: {
        Notifications.registry.unregisterForAll(newsWidget);
    }

    titleKey: "News"
    id: newsWidget

    configurationView: PXEditableSheet {
        id: newsEditWidget
        rowTextInputDelgate: newsWidget
        rowTextInputIdentifier: "news text input"
        modelIdentifier: "news config model"
        arrayResultDelegate: newsWidget
        viewComponent: Component {
            PXRowTextEdit {}
        }
    }

    contentView: PXListModelArray {
        id: newsViewModel
        modelIdentifier: "news view model"
        arrayResultDelegate: newsWidget
        viewComponent: Component {
            PXRowNews {}
        }
    }
}
