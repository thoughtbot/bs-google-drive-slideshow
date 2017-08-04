const path = require("path");

module.exports = {
  entry: "./lib/js/src/demo.js",
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "dist")
  }
};
