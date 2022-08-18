export function unsafeNew() {
  return new Headers();
}

export function unsafeAppend(key, value, headers) {
  return headers.append(key, value);
}

export function unsafeFromRecord(r) {
  return new Headers(r);
}

export function _toArray(tuple, headers) {
  return Array.from(headers.entries(), function (pair) {
    return tuple(pair[0])(pair[1]);
  });
}

export function fromObject(obj) {
  return new Headers(obj);
}
