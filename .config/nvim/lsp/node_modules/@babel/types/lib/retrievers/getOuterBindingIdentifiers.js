import getBindingIdentifiers from "./getBindingIdentifiers.js";
export default getOuterBindingIdentifiers;
function getOuterBindingIdentifiers(node, duplicates) {
  return getBindingIdentifiers(node, duplicates, true);
}

//# sourceMappingURL=getOuterBindingIdentifiers.js.map
