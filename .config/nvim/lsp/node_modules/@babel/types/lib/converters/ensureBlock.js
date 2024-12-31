import toBlock from "./toBlock.js";
export default function ensureBlock(node, key = "body") {
  const result = toBlock(node[key], node);
  node[key] = result;
  return result;
}

//# sourceMappingURL=ensureBlock.js.map
