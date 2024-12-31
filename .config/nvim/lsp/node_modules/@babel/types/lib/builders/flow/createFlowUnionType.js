import { unionTypeAnnotation } from "../generated/index.js";
import removeTypeDuplicates from "../../modifications/flow/removeTypeDuplicates.js";
export default function createFlowUnionType(types) {
  const flattened = removeTypeDuplicates(types);
  if (flattened.length === 1) {
    return flattened[0];
  } else {
    return unionTypeAnnotation(flattened);
  }
}

//# sourceMappingURL=createFlowUnionType.js.map
