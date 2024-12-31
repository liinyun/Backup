import inheritTrailingComments from "./inheritTrailingComments.js";
import inheritLeadingComments from "./inheritLeadingComments.js";
import inheritInnerComments from "./inheritInnerComments.js";
export default function inheritsComments(child, parent) {
  inheritTrailingComments(child, parent);
  inheritLeadingComments(child, parent);
  inheritInnerComments(child, parent);
  return child;
}

//# sourceMappingURL=inheritsComments.js.map
