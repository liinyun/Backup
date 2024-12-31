import addComments from "./addComments.js";
export default function addComment(node, type, content, line) {
  return addComments(node, type, [{
    type: line ? "CommentLine" : "CommentBlock",
    value: content
  }]);
}

//# sourceMappingURL=addComment.js.map
