import traverseFast from "../traverse/traverseFast.js";
import removeProperties from "./removeProperties.js";
export default function removePropertiesDeep(tree, opts) {
  traverseFast(tree, removeProperties, opts);
  return tree;
}

//# sourceMappingURL=removePropertiesDeep.js.map
