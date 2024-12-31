export default function _defineAccessor(type, obj, key, fn) {
  var desc = {
    configurable: true,
    enumerable: true
  };
  desc[type] = fn;
  return Object.defineProperty(obj, key, desc);
}

//# sourceMappingURL=defineAccessor.js.map
