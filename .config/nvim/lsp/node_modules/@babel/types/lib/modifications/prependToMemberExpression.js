import { memberExpression } from "../builders/generated/index.js";
import { isSuper } from "../index.js";
export default function prependToMemberExpression(member, prepend) {
  if (isSuper(member.object)) {
    throw new Error("Cannot prepend node to super property access (`super.foo`).");
  }
  member.object = memberExpression(prepend, member.object);
  return member;
}

//# sourceMappingURL=prependToMemberExpression.js.map
