import { tsUnionType } from "../generated/index.js";
import removeTypeDuplicates from "../../modifications/typescript/removeTypeDuplicates.js";
import { isTSTypeAnnotation } from "../../validators/generated/index.js";
export default function createTSUnionType(typeAnnotations) {
  const types = typeAnnotations.map(type => {
    return isTSTypeAnnotation(type) ? type.typeAnnotation : type;
  });
  const flattened = removeTypeDuplicates(types);
  if (flattened.length === 1) {
    return flattened[0];
  } else {
    return tsUnionType(flattened);
  }
}

//# sourceMappingURL=createTSUnionType.js.map
