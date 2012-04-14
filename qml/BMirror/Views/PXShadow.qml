// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {

    property bool isTop: true

    id: shadow
    height: 10;
    width: parent.width;
    z: 1;

    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: shadow.isTop ? "black" : "transparent";
        }
        GradientStop {
            position: 1.00;
            color: shadow.isTop ? "transparent" : "black";
        }
    }
}
