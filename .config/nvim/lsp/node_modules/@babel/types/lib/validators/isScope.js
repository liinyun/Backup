import { isFunction, isCatchClause, isBlockStatement, isScopable, isPattern } from "./generated/index.js";
export default function isScope(node, parent) {
  if (isBlockStatement(node) && (isFunction(parent) || isCatchClause(parent))) {
    return false;
  }
  if (isPattern(node) && (isFunction(parent) || isCatchClause(parent))) {
    return true;
  }
  return isScopable(node);
}

//# sourceMappingURL=isScope.js.map
