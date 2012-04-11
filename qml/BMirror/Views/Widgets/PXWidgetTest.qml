import "../"
import "../Controls"
import QtQuick 1.1

PXWindowWidget {

    id: testWidget

    contentView: Rectangle {
        width: 200
        height: 100
        color: "green"

        PXButton {
            textKey: "sample"
            buttonDelegate: testWidget
            buttonIdentifier: "sample button"
        }
    }
}
