Qt.include("../PXApp.js");

var removeRowFromModel = function (row, model, controller, callback) {

    var i = 0, current_row;

    for (i; i < model.count; i++) {

        current_row = model.get(i);

        if (current_row.rowTextKey == row.identifier()) {
            model.remove(i);
            callback(row, model, controller);
        }
    }
};

var updateCheckmarks = function (model, identifier, current_value) {

    var row,
        i = 0,
        index = -1,
        isCurrent = false;

    for (i; i < model.count; i++) {

        row = model.get(i);
        row.isCurrent = row[identifier] === current_value;

        if (row.isCurrent) {
            index = i;
        }
    }

    return index;
}
