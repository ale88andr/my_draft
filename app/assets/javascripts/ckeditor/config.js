if(typeof(CKEDITOR) != 'undefined')
{
  CKEDITOR.editorConfig = function(config) {
    config.extraPlugins = 'placeholder';
    config.toolbar = [ [ 'Source', 'Bold' ], ['CreatePlaceholder'] ];
  }
}