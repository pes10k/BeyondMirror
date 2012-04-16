// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import "../Controls"
import "../Rows"
import "../"
import "../../JS/PXData.js" as PXData
import "../../JS/PXNotifications.js" as Notifications
import "../../JS/Controllers/PXWidgetVideo.js" as VideoController
import "../../JS/Controllers/PXController.js" as Controller
import QtQuick 1.1

PXWindowWidget {

    //var videoData = PXData.videoData1

    property variant currentTab: tvshowsTab;
    property string currentSource: 'iTunes'

    function updateCheckmarks (value) {

        return Controller.updateCheckmarks(videoWidgetConfig.getViewModel(), "rowTextKey", value);
    }

    // Implementation of the "Array List Model Delegate Protocol"
    function rowsForModel (model, modelIdentifier) {
        var videoData = [];
        if(currentSource === 'iTunes')
            videoData = PXData.videoData1
        else if (currentSource === 'XBox')
            videoData = PXData.videoData2

        var current_data,
            i = 0;

        if (modelIdentifier === "video model") {

            if (videoWidget.currentTab == moviesTab) {

                current_data = videoData['movies'];

            } else if (videoWidget.currentTab == tvshowsTab) {

                current_data = videoData['tvshows'];

            } else if (videoWidget.currentTab == podcastTab) {

                current_data = videoData['podcasts'];

            }

            model.clear();

            for (i; i < current_data.length; i++) {

                model.append({"rowTextKey" : current_data[i]});
            }
        }
    }


    function tabItemClicked (tabItem) {

        if(currentTab===tabItem)
            return

        currentTab.state = "DISABLED"
        switch (tabItem.tabIdentifier) {

        case "movies tab":
            currentTab = moviesTab
            videoModel.refresh();
            break;

        case "tvshows tab":
            currentTab = tvshowsTab
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

    configurationView: Rectangle {

        function rowsForModel (model, modelIdentifier) {
            VideoController.addDataSourcesToModel(model);
            updateCheckmarks(VideoController.videoSources.currentSource(globalVariables.currentUserId));
        }

        id: configPane
        anchors.fill: parent
        visible: parent.height > 40

        PXText {
            id: dataSourceLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            textKey: "Video Information Data Source"
            color: "black"
            horizontalAlignment: Text.AlignHCenter
        }

        PXListModelArray {
            id: videoWidgetConfig
            arrayResultDelegate: configPane
            modelIdentifier: "video source model"
            viewComponent: Component {
                PXRowCheck {
                    function mouseAreaEvent (mouseArea) {
                        VideoController.videoSources.setSource(globalVariables.currentUserId, rowTextKey);
                        videoWidget.updateCheckmarks(rowTextKey);
                        currentSource = rowTextKey
                        videoModel.refresh()
                    }
                }
            }

            width: 260
            anchors.top: dataSourceLabel.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
        }
    }

    contentView: Rectangle {

        color: "transparent"
        anchors.fill: parent;
        anchors.horizontalCenter: parent.horizontalCenter

        PXTab {
            id: moviesTab
            tabIdentifier: "movies tab"
            anchors.right: tvshowsTab.left
            anchors.rightMargin: 20
            textKey: "Movies"
            tabDelegate: videoWidget
            state: "DISABLED"
        }

        PXTab {
            id: tvshowsTab
            tabIdentifier: "tvshows tab"
            anchors.horizontalCenter: parent.horizontalCenter
            textKey: "TV Shows"
            tabDelegate: videoWidget
            state: "ABLED"
        }

        PXTab {
            id: podcastTab
            tabIdentifier: "podcast tab"
            anchors.left: tvshowsTab.right
            anchors.leftMargin: 20
            textKey: "Podcasts"
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
                                "source" : "../../Images/" + rowTextKey + ".png"
                            }
                        });
                    }
                }
            }
        }
    }
}
