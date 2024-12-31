import { isIdentifier, isImportDefaultSpecifier } from "./generated/index.js";
export default function isSpecifierDefault(specifier) {
  return isImportDefaultSpecifier(specifier) || isIdentifier(specifier.imported || specifier.exported, {
    name: "default"
  });
}

//# sourceMappingURL=isSpecifierDefault.js.map
