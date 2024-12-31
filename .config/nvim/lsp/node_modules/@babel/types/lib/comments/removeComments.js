import { COMMENT_KEYS } from "../constants/index.js";
export default function removeComments(node) {
  COMMENT_KEYS.forEach(key => {
    node[key] = null;
  });
  return node;
}

//# sourceMappingURL=removeComments.js.map
