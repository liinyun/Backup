import isValidIdentifier from "./isValidIdentifier.js";
const RESERVED_WORDS_ES3_ONLY = new Set(["abstract", "boolean", "byte", "char", "double", "enum", "final", "float", "goto", "implements", "int", "interface", "long", "native", "package", "private", "protected", "public", "short", "static", "synchronized", "throws", "transient", "volatile"]);
export default function isValidES3Identifier(name) {
  return isValidIdentifier(name) && !RESERVED_WORDS_ES3_ONLY.has(name);
}

//# sourceMappingURL=isValidES3Identifier.js.map
