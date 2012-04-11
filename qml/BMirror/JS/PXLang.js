.pragma library

/**
 * @file
 * Provides a set of functions, used to provide translation functionality
 * between different languages.  This replaces the default, QT provided
 * translation libraries, and provides the benefit of allowing realtime /
 * immediate translation.
 */

/**
 * Returns a translation table, used for translating strings between
 * different languages.  This is implemented as a closure, to prevent
 * needing to initialize the large translation table on each call.
 * Instead, the returned funciton has access to one, shared version
 * of the table.
 *
 * @return object
 *   The returned object has keys, describing languages, in their
 *   ISO 639-1 alpha-2 form.  The values are also objects, with the
 *   untranslated verison of each string as a key, and the translated
 *   version as the value.
 */
var translationTable = (function () {

    var table = false;

    return function () {

        if (table === false) {

            table = {
                "de" : {},
            };
        }

        return table;
    }
}());

/**
 * Translates a term between English and the current, system language
 * setting.  If no translation is available for the given string in the
 * currently selected language, the English version is returned and
 * an error is logged.
 *
 * @param string term
 *   An untranslated, English verison of the desired text
 *
 * @return string
 *   The translated version of the string, if available.  Otherwise,
 *   returns back the provided English version.
 */
var translateTerm = function (term) {

    var current_language, table;

    current_language = "en";

    if (current_language === "en") {

        return term;

    } else {

        table = translationTable();

        if (table[current_language] && table[current_language][term]) {

            return table[current_language][term];

        } else {

            console.log("No translation for key '" + term + "' for language '" + current_language + "'");
            return term;
        }
    }
};
