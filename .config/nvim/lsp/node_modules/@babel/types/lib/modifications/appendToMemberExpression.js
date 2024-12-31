import { memberExpression } from "../builders/generated/index.js";
export default function appendToMemberExpression(member, append, computed = false) {
  member.object = memberExpression(member.object, member.property, member.computed);
  member.property = append;
  member.computed = !!computed;
  return member;
}

//# sourceMappingURL=appendToMemberExpression.js.map
