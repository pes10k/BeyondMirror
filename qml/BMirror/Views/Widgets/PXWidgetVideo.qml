// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import "../Controls"
import "../Rows"
import "../"
import "../../JS/PXData.js" as PXData
import "../../JS/PXNotifications.js" as Notifications
import QtQuick 1.1

PXWindowWidget {

    property variant currentTab: tvShowsTab;

    // Implementation of the "Array List Model Delegate Protocol"
    function rowsForModel (model, modelIdentifier) {

        var current_data,
            i = 0;

        if (modelIdentifier === "video model") {

            if (videoWidget.currentTab == moviesTab) {

                current_data = PXData.movies;

            } else if (videoWidget.currentTab == tvShowsTab) {

                current_data = PXData.tVShows;

            } else if (videoWidget.currentTab == podcastTab) {

                current_data = PXData.podcasts;

            }

            model.clear();

            for (i; i < current_data.length; i++) {

                model.append({"rowTextKey" : current_data[i]});
            }
        }
    }

    function tabItemClicked (tabItem) {

        currentTab.state = "DISABLED"
        switch (tabItem.tabIdentifier) {

        case "movies tab":
            currentTab = moviesTab
            videoModel.refresh();
            break;

        case "tVShows tab":
            currentTab = tvShowsTab
            videoModel.refresh();
            break;

        case "podcast tab":
            currentTab = podcastTab
            videoModel.refresh();
            break;
        }
    }

    id: videoWidget
    titleKey: "Video"

    contentView: Rectangle {

        color: "transparent"
        anchors.fill: parent;
        anchors.horizontalCenter: parent.horizontalCenter

        PXTab {
            id: moviesTab
            tabIdentifier: "movies tab"
            color:"#808080"
            anchors.right: tvShowsTab.left
            anchors.rightMargin: 60
            textKey:"movies"
            tabDelegate: videoWidget
            state: "DISABLED"
        }

        PXTab {
            id: tvShowsTab
            tabIdentifier: "tVShows tab"
            color:"#000000"
            anchors.horizontalCenter: parent.horizontalCenter
            textKey:"TV Shows"
            tabDelegate: videoWidget
            state: "ABLED"
        }

        PXTab {
            id: podcastTab
            tabIdentifier: "podcast tab"
            color:"#808080"
            anchors.left: tvShowsTab.right
            anchors.leftMargin: 60
            textKey:"podcast"
            tabDelegate: videoWidget
            state: "DISABLED"
        }

        PXListModelArray {

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: moviesTab.bottom
            anchors.topMargin: 0

            id: videoModel
            modelIdentifier: "video model"
            arrayResultDelegate: videoWidget
            viewComponent: Component {
                PXRowNext {
                    function mouseAreaEvent (mouseArea) {
                        Notifications.registry.sendNotification("request for window", {
                            "window" : "video window",
                            "params" : {
                                "title" : rowTextKey,
                                "source" : ""
                            }
                        });
                    }
                }
            }
        }
    }
}
