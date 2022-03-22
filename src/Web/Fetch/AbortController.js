"use strict";

export function new() {
  return new AbortController();
}

export function abort(controller) {
  return function() {
    return controller.abort();
  };
}

export function signal(controller) {
  return controller.signal;
}
