import { anyTypeAnnotation, stringTypeAnnotation, numberTypeAnnotation, voidTypeAnnotation, booleanTypeAnnotation, genericTypeAnnotation, identifier } from "../generated/index.js";
export default createTypeAnnotationBasedOnTypeof;
function createTypeAnnotationBasedOnTypeof(type) {
  switch (type) {
    case "string":
      return stringTypeAnnotation();
    case "number":
      return numberTypeAnnotation();
    case "undefined":
      return voidTypeAnnotation();
    case "boolean":
      return booleanTypeAnnotation();
    case "function":
      return genericTypeAnnotation(identifier("Function"));
    case "object":
      return genericTypeAnnotation(identifier("Object"));
    case "symbol":
      return genericTypeAnnotation(identifier("Symbol"));
    case "bigint":
      return anyTypeAnnotation();
  }
  throw new Error("Invalid typeof value: " + type);
}

//# sourceMappingURL=createTypeAnnotationBasedOnTypeof.js.map
