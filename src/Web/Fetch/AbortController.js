const newImpl = function () {
  return new AbortController();
};
export { newImpl as new };

export function abort(controller) {
  return function() {
    return controller.abort();
  };
}

export function signal(controller) {
  return controller.signal;
}
