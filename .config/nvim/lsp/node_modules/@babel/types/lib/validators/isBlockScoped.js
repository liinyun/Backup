import { isClassDeclaration, isFunctionDeclaration } from "./generated/index.js";
import isLet from "./isLet.js";
export default function isBlockScoped(node) {
  return isFunctionDeclaration(node) || isClassDeclaration(node) || isLet(node);
}

//# sourceMappingURL=isBlockScoped.js.map
