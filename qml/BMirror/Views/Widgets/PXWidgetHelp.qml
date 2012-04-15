// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import "../"
import "../Controls"
import "../Rows"
import "../"
import "../../JS/PXData.js" as PXData
import QtQuick 1.1

PXWindowWidget {

    function rowsForModel (model, modelIdentifier){

        if(modelIdentifier === "help model"){

            for (var i = 0; i < PXData.widgets.length; i++){

                model.append({"rowTextKey" : PXData.widgets[i]});

            }
        }
    }

    function helpInfor(headline){
        return PXData.helpText[headline]
    }

    id: helpWidget
    titleKey: "Help"

    contentView: Rectangle {
        anchors.fill:parent

        Rectangle {
            //id: helpModel
            height: parent.height
            width: parent.width*0.3
            anchors.left: parent.left
            PXListModelArray {
                anchors.fill: parent
                id: helpModel
                modelIdentifier: "help model"
                arrayResultDelegate: helpWidget
                viewComponent: Component {
                    PXRowNext {
                        function mouseAreaEvent (mouseArea) {
                            console.log("Clicked");
                            headline.textKey = rowTextKey;
                            content.textKey = helpInfor (headline.textKey)
                        }
                    }
                }
            }

        }

        Rectangle{
            height: parent.height
            width: parent.width*0.7
            anchors.right: parent.right
            PXText {
                id: headline
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20
                color: "black"
                //textKey: "headline"

            }

            PXText {
                id: content
                anchors.top: headline.bottom
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.right: parent.right
                //wrapMode: Text.WordWrap
                width: 80
                color: "black"
                textKey: ""
            }
        }

    }
}
