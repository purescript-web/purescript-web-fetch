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
  var arr = [];
  for (var pair of headers.entries()) {
    arr.push(tuple(pair[0])(pair[1]));
  }
  return arr;
}

exports.fromObject = function(obj) {
  return new Headers(obj);
};