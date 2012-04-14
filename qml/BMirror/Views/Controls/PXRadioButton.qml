// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../"

Rectangle {
    id: radioButton
    width: 60
    height: 30
    property string textKey
    property variant delegate
    PXText {
        id:buttonText
        textKey:radioButton.textKey
        color:'black'
        font.pixelSize: 20

    }
    Image {
        id:radio
        source: "../../Images/radio_button.png"
        anchors.verticalCenter: buttonText.verticalCenter
        anchors.right: buttonText.left
        anchors.rightMargin: 10
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                    if (radioButton.delegate) {
                        radioButton.delegate.radioButtonClicked(radioButton);
                    }
            }
        }
        Image{
            id: dot
            source:"../../Images/dot.png"
            anchors.horizontalCenter: radio.horizontalCenter
            anchors.verticalCenter: radio.verticalCenter
        }
    }
    state:"UNSELECTED"
    states: [
        State {
            name: "SELECTED"
            PropertyChanges {
                target: dot
                visible:true
            }
        },
        State {
            name: "UNSELECTED"
            PropertyChanges {
                target:dot
                visible:false
            }
        }
    ]
}
