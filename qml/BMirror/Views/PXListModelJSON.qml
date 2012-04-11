/**
 * @file
 * A QML element that wraps a list view that depicts rows
 * provided by a JSON feeding service.
 */

import "../JS/PXJSONModel.js" as JSONSource
import QtQuick 1.1

/**
 * "JSON List Model Delegate Protocol" Definition
 *
 * Required Methods:
 *
 * - jsonResults (rows, model, modelIdentifier)
 *   This function must be implemented by this model's delegate.  The delegate
 *   is responsible for taking the given array of data and providing it to
 *   the ListModel object, with the needed properties / roles populated.
 */

Rectangle {

    /**
      * A full, absolute URL, pointing to a JSON feeding service.
      */
    property string feedUrl;

    /**
      * A string, uniquely identifying this instance of the model.
      */
    property string modelIdentifier;

    /**
     * A weak reference to an object that implements the
     * "JSON List Model Delegate Protocol"
     */
    property variant jsonResultDelegate;

    property variant viewComponent: Component {
        Rectangle {
            color: "red"
        }
    }

    // Private reference to a javascript object, used to track and fetch JSON
    // updates
    property variant jsonFetcher;

    /**
      * Removes all rows from the model / listview, pulls in a new JSON string,
      * and repopulates the view.
      */
    function refresh () {

        var num_items = localListModel.count, i = 0

        for (i; i < num_items; i++) {
            localListModel.remove(i);
        }

        localListModelJSON.fetch(function (rows, model) {
            jsonResultDelegate.jsonResults(rows, model, modelIdentifier);
        });
    }

    /**
      * Returns a reference to the wrapped / encapsulated QML List View Model
      */
    function getViewModel () {
        return localListModel;
    }

    /**
      * Returns a reference to the wrapped / encapsulated QML List View Delagate
      */
    function getViewDelegate () {
        return localListDelegate;
    }

    /**
      * Returns a reference to the wrapped / encapsulated QML List View object
      */
    function getListView () {
        return localListView;
    }

    id: localListModelJSON;
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

                jsonFetcher = JSONSource.jsonSource(feedUrl, localListModel);

                jsonFetcher(function (rows, model) {
                    jsonResultDelegate.jsonResults(rows, model, modelIdentifier);
                });
            }

            id: localListModel;
        }
    }
}
