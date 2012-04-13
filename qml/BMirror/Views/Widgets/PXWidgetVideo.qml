// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import "../"
import "../Controls"
import QtQuick 1.1
import "../../JS/PXData.js" as PXData

PXWindowWidget {

    function fillModel(listModel,dataArray){
        listModel.clear();
        for(var i=0;i<dataArray.length;i++)
            videoModel.append({"name":dataArray[i]})
    }

    function tabItemClicked(tabItem){
        currentTab.state = "DISABLED"
        switch (tabItem.tabIdentifier){
        case "movies tab":
            currentTab = movies
            fillModel(videoModel,PXData.movies)
            break;
        case "tVShows tab":
            currentTab = tVShows
            fillModel(videoModel,PXData.tVShows)
            break;
        case "podcast tab":
            currentTab = podcast
            fillModel(videoModel,PXData.podcasts)
            break;
        }
    }

    Component.onCompleted: {
        fillModel(videoModel,PXData.tVShows)
    }

    id:videoWidget
    titleKey:"Video"

    //record the current slected tab
    property variant currentTab:tVShows;
    //
    property variant playManager;

    contentView:Rectangle{
        //visible:false
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.fill: parent
        PXTab{
            id:movies
            tabIdentifier: "movies tab"
            color:"#808080"
            anchors.right: tVShows.left
            anchors.rightMargin: 60
            textKey:"movies"
            tabDelegate: videoWidget
            state: "DISABLED"
        }
        PXTab{
            id:tVShows
            tabIdentifier: "tVShows tab"
            color:"#000000"
            anchors.horizontalCenter:parent.horizontalCenter
            textKey:"TV Shows"
            tabDelegate: videoWidget
            state:"ABLED"
        }
        PXTab{
            id:podcast
            tabIdentifier: "podcast tab"
            color:"#808080"
            anchors.left: tVShows.right
            anchors.leftMargin: 60
            textKey:"podcast"
            tabDelegate: videoWidget
            state: "DISABLED"
        }

        Rectangle{
            id:infor
            color:"white"
            width:550
            anchors.top: tVShows.bottom
            height:parent.parent.height-tVShows.height-10
            anchors.horizontalCenter: tVShows.horizontalCenter
            //visible:movies.tabInforVisibility

            ListModel {
                id: videoModel
            }
            Component {
                id: videoDelegate
                Item {
                    width: 550; height: 60
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize:20
                        width: 550; height: 40
                        text: name
                        verticalAlignment:Text.AlignVCenter
                        //horizontalAlignment: Text.AlignHCenter
                        //anchors.fill: parent
                    }


                    Image{
                        source:"../../Images/forward-icon.png"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                //console.log(name)
                                playManager.playVideo(name);
                            }
                        }
                    }

                }

            }
            ListView {
                anchors.fill: parent
                model: videoModel
                delegate: videoDelegate
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                focus: true
            }
        }
    }
}
