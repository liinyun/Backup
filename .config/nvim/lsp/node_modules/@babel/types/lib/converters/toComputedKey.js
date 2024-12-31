import { isIdentifier } from "../validators/generated/index.js";
import { stringLiteral } from "../builders/generated/index.js";
export default function toComputedKey(node, key = node.key || node.property) {
  if (!node.computed && isIdentifier(key)) key = stringLiteral(key.name);
  return key;
}

//# sourceMappingURL=toComputedKey.js.map
