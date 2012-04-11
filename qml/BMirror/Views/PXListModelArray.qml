/**
 * @file
 * This object encapuslates displaying a list of items, fed from
 * an array of data.  The object relies on an object
 * implementing the "Array List Model Delegate Protocol",
 * as described below, to provide the array to the model
 * and break it up into rows that the Component can depict.
 */

/**
 * "Array List Model Delegate Protocol" Definition
 *
 * Required Methods:
 *
 * - rowsForModel (model, modelIdentifier)
 *   Objects implementing this function should add the desired row data
 *   directly to the provided model, using the ListModel.append() method
 */

import QtQuick 1.1

Rectangle {

    /**
      * A string, uniquely identifying this instance of the model.
      */
    property string modelIdentifier;

    property variant arrayResultDelegate;
    property variant viewComponent: Component {
            id: localListDelegate;
            Rectangle {}
        }

    function getViewModel () {
        return localListModel;
    }

    function getViewDelegate () {
        return localListDelegate;
    }

    function getListView () {
        return localListView;
    }

    id: localListModelArray;
    width: parent.width;
    height: parent.height;
    color: "transparent";

    ListView {

        id: localListView;
        clip: true;
        anchors.fill: parent;
        delegate: viewComponent;

        model: ListModel {
            Component.onCompleted: {
                arrayResultDelegate.rowsForModel(localListView.model, modelIdentifier);
            }
            id: localListModel;
        }
    }
}