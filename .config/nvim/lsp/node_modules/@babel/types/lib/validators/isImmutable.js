import isType from "./isType.js";
import { isIdentifier } from "./generated/index.js";
export default function isImmutable(node) {
  if (isType(node.type, "Immutable")) return true;
  if (isIdentifier(node)) {
    if (node.name === "undefined") {
      return true;
    } else {
      return false;
    }
  }
  return false;
}

//# sourceMappingURL=isImmutable.js.map
