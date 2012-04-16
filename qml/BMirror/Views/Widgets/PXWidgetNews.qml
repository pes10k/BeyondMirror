import "../../JS/PXApp.js" as App
import "../../JS/Controllers/PXWidgetNews.js" as NewsController
import "../../JS/Controllers/PXController.js" as GenericController
import "../../JS/PXNotifications.js" as Notifications
import "../../Views/Rows"
import "../Controls"
import "../"
import QtQuick 1.1

PXWindowWidget {

    // Implementation of the "Row Text Input Delegate Protocol"
    function rowTextInputClicked (rowTextInput) {

        if (rowTextInput.rowTextInputIdentifier === "news text input") {

            NewsController.news.addFeed(globalVariables.currentUserId, rowTextInput.text(), function (isSuccess) {

                if (!isSuccess) {

                    newsEditWidget.setFeedback("Duplicate topic!", 2000, true);

                } else {

                    newsEditWidget.modelArray().refresh();
                    newsViewModel.refresh();
                    rowTextInput.clear();

                }
            });
        }
    }

    // Implementation of the "Array List Model Delegate Protocol"
    function rowsForModel (model, modelIdentifier) {

        if (modelIdentifier === "news view model") {

            NewsController.addCurrentUsersNewsItemsToModel(globalVariables.currentUserId, model);

        } else if (modelIdentifier === "news config model") {

            NewsController.addCurrentUsersNewsFeedsToModel(globalVariables.currentUserId, model);

        }
    }

    // Implementation of "Notification Delegate Protocol"
    function receivedNotification (notification, params) {

        if (notification === "edit row delete clicked") {

            if (params.modelIdentifier == "news config model") {

                GenericController.removeRowFromModel(
                    params.row,
                    newsEditWidget.modelArray().getViewModel(),
                    newsEditWidget.modelArray(),
                    function () {
                        NewsController.news.removeFeed(globalVariables.currentUserId, params.row.identifier());
                        newsEditWidget.modelArray().refresh();
                        newsViewModel.refresh();
                    }
                );
            }

        } else if (notification === "logout") {

            newsWidget.logout();

        } else if (notification === "login") {

            newsWidget.login();

        }
    }

    Component.onCompleted: {
        Notifications.registry.registerForNotification(newsWidget, "edit row delete clicked");
        Notifications.registry.registerForNotification(newsWidget, "logout");
        Notifications.registry.registerForNotification(newsWidget, "login");
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
        rowTextInputTextKey: "Add news topics:"
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
