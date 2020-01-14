exports.new = function() {
  return new AbortController();
};

exports.abort = function(controller) {
  return function() {
    return controller.abort();
  };
};

exports.signal = function(controller) {
  return controller.signal;
};