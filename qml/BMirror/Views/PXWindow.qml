    import "../JS/PXWindowSerializer.js" as WindowSerializer
import "../JS/PXNotifications.js" as Notifications
import QtQuick 1.1

Rectangle {

    function isOpen () {
        return windowBase.visible == true;
    }

    function close () {
        windowBase.state = "CLOSING"
    }

    function open () {
        windowBase.z = globalVariables.currentZIndex++;
        windowBase.state = "APPEARING"
    }

    id: windowBase
    color: "#000000"
    radius: 5
    border.width: 1
    border.color: "#ffffff"

    states: [
        State {
            name: "CLOSING"
            PropertyChanges {
                target: windowBase
                opacity: 0
            }
        },
        State {
            name: "APPEARING"
            PropertyChanges {
                target: windowBase
                opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            to: "APPEARING"
            ScriptAction {
                script: {
                    windowBase.visible = true;
                    Notifications.registry.sendNotification("window appearing", {"window" : windowBase});
                }
            }
            PropertyAnimation {
                properties: "opacity"
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            to: "CLOSING"
            SequentialAnimation {
                PropertyAnimation {
                    properties: "opacity";
                    easing.type: Easing.InOutQuad
                }
                ScriptAction {
                    script: {
                        windowBase.visible = false;
                        Notifications.registry.sendNotification("window closed", {"window" : windowBase});
                    }
                }
            }
        }
    ]
}
