//# sourceURL=smartRUtils.js

'use strict';

window.smartRApp.factory('smartRUtils', ['$q', function($q) {

    var service = {};

    service.conceptBoxMapToConceptKeys = function smartRUtils_conceptBoxMapToConceptKeys(conceptBoxMap) {
        var allConcepts = {};
        Object.keys(conceptBoxMap).forEach(function(group) {
            var concepts = conceptBoxMap[group];
            concepts.forEach(function(concept, idx) {
                allConcepts[group + '_' + 'n' + idx] = concept;
            });
        });
        return allConcepts;
    };

    /**
     * Creates a CSS safe version of a given string
     * This should be used consistently across the whole of SmartR to avoid data induced CSS errors
     *
     * @param str
     * @returns {string}
     */
    service.makeSafeForCSS = function smartRUtils_makeSafeForCSS(str) {
        return String(str).replace(/[^a-z0-9]/g, function(s) {
            var c = s.charCodeAt(0);
            if (c === 32) {
                return '-';
            }
            if (c >= 65 && c <= 90) {
                return '_' + s.toLowerCase();
            }
            return '__' + ('000' + c.toString(16)).slice(-4);
        });
    };

    service.shortenConcept = function smartRUtils_shortenConcept(concept) {
        var split = concept.split('\\');
        split = split.filter(function(str) { return str !== ''; });
        return split[split.length - 2] + '/' + split[split.length - 1];
    };
    
    service.mouseX = function(root) {
        var svg = $(root).children('svg');
        var mouseXPos = typeof d3.event.sourceEvent !== 'undefined' ? d3.event.sourceEvent.pageX : d3.event.clientX;
        return mouseXPos - svg.offset().left + svg.position().left;
    };

    service.mouseY = function(root) {
        var svg = $(root).children('svg');
        var mouseYPos = typeof d3.event.sourceEvent !== 'undefined' ? d3.event.sourceEvent.pageY : d3.event.clientY;
        return mouseYPos - svg.offset().top + svg.position().top;
    };
    
    service.getMaxWidth = function(selection) {
        return selection[0].map(function (d) {
            return d.getBBox().width;
        }).max();
    };

    service.countCohorts = function() {
        return !window.isSubsetEmpty(1) + !window.isSubsetEmpty(2);
    };

    service.getSubsetIds = function smartRUtil_getSubsetIds() {
        var defer = $q.defer();

        function resolveResult() {
            var res = window.GLOBAL.CurrentSubsetIDs.map(function (v) {
                return v || null;
            });
            if (res.some(function (el) {
                    return el !== null;
                })) {
                defer.resolve(res);
            } else {
                defer.reject();
            }
        }

        for (var i = 1; i <= window.GLOBAL.NumOfSubsets; i++) {
            if (!window.isSubsetEmpty(i) && !window.GLOBAL.CurrentSubsetIDs[i]) {
                window.runAllQueries(resolveResult);
                return defer.promise;
            }
        }

        resolveResult();

        return defer.promise;
    };

    return service;
}]);
