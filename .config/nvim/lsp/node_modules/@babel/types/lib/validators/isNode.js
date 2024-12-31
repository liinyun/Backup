import { VISITOR_KEYS } from "../definitions/index.js";
export default function isNode(node) {
  return !!(node && VISITOR_KEYS[node.type]);
}

//# sourceMappingURL=isNode.js.map
