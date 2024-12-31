import matchesPattern from "./matchesPattern.js";
export default function buildMatchMemberExpression(match, allowPartial) {
  const parts = match.split(".");
  return member => matchesPattern(member, parts, allowPartial);
}

//# sourceMappingURL=buildMatchMemberExpression.js.map
