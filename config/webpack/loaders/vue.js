module.exports = {
  test: /\.vue(\.erb)?$/,
  use: [{
    loader: 'vue-loader',
    options: PnpWebpackPlugin.tsLoaderOptions({
      appendTsSuffixTo: [/\.vue$/]
    })
  }]
}
