export function headers(resp) {
  return resp.headers;
}

export function ok(resp) {
  return resp.ok;
}

export function redirected(resp) {
  return resp.redirected;
}

export function status(resp) {
  return resp.status;
}

export function statusText(resp) {
  return resp.statusText;
}

export function url(resp) {
  return resp.url;
}

export function body(resp) {
  return function() {
    return resp.body;
  };
}

export function arrayBuffer(resp) {
  return function() {
    return resp.arrayBuffer();
  };
}

export function blob(resp) {
  return function() {
    return resp.blob();
  };
}

export function text(resp) {
  return function() {
    return resp.text();
  };
}

export function json(resp) {
  return function() {
    return resp.json();
  };
}
