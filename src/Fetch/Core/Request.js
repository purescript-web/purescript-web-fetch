export function _unsafeNew(url, options) {
  try {
    return new Request(url, options);
  } catch (e) {
    console.error(e);
    throw e;
  }
}
