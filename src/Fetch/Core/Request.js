export function _unsafeNew(url, options) {
  try {
    return new Request(url, { ...options, duplex: 'half' });
  } catch (e) {
    console.error(e);
    throw e;
  }
}
