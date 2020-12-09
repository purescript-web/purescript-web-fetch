"use strict";

exports.unsafeNew = function() {
  return new Headers();
};

exports.unsafeAppend = function(key, value, headers) {
  return headers.append(key, value);
};

exports.unsafeFromRecord = function(r) {
  return new Headers(r);
};

exports._toArray = function(tuple, headers) {
  return Array.from(headers.entries(), function (pair) {
    return tuple(pair[0])(pair[1]);
  });
};

exports.fromObject = function(obj) {
  return new Headers(obj);
};
