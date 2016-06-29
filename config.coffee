exports.config =
  # See docs at https://github.com/brunch/brunch/blob/stable/docs/config.md.
  npm:
    enabled:false
  modules:
    definition: false
    wrapper: false
  sourceMaps: false
  paths:
    public: 'target/public'
    watched: ['src']
  server:
    noPushState:true
    # path: 'server.js'
    # port: 3335
  conventions:
    ignored:[
      /[\\/]_/,
      /vendor[\\/]node[\\/]/,
      /vendor[\\/](j?ruby-.*|bundle)[\\/]/,
      /\.spec\.js$/
    ]
    assets:  /^src[\/\\]main(\/|\\)assets(\/|\\)/
  overrides:
  # Override properties for non local build so that test data is not included.
    production:
      optimize:true
      paths:
        public: 'target/server/ibpmwebmanager'
      conventions:
        assets:/^src[\/\\]main(\/|\\)assets(?!(\/|\\)json)/
    devint:
      optimize:false
      paths:
        public: 'target/devint/ibpmwebmanager'
      conventions:
        assets:/^src[\/\\]main(\/|\\)assets(?!(\/|\\)json)/  
  files:
    javascripts:
      joinTo:
        'js/jquery.js': /^(bower_components)((\/|\\)jquery)((\/|\\)dist)/
        'js/exts.js': /^(bower_components)(?!(\/|\\)jquery)/
        'js/common.js': /^src[\/\\]main(\/|\\)(common)(\/|\\)/
        'js/config.js': /^src[\/\\]main(\/|\\)(config)(\/|\\)/
        'js/vendor.js': /^src[\/\\]main(\/|\\)(vendor)/
        'js/categories.js': /^src[\/\\]main(\/|\\)(admin)(\/|\\)(categories)/
      order:
        before: [
          'src/main/common/utils/lazyload.js',
          'src/main/common/utils/dependencyResolver.js'
          'bower_components/angular/angular.min.js'
          'src/main/common/scripts/app.js'
        ]
        after: [
        ]
    stylesheets:
      joinTo:
        'css/ext.css' : /^(bower_components)(\/|\\)((bootstrap)|(ui\-lightness))(\/|\\)/
        'css/styles.css': /^src[\/\\]main(\/|\\)styles(\/|\\)/
      order:
        before:[
          'src/main/styles/custom-fonts.css'
        ]  
    templates:
      joinTo:
        'js/dontUseMe' : /^src[\/\\]main/ # dirty hack for Jade compiling.
  plugins:
    autoReload:
      enabled: off
    jadePages:
      destination: (path) ->
        path.replace /^src[\/\\]main[\/\\](.*)\.jade$/, "$1.html"
      jade:
        pretty: true
    uglify:
      mangle: true
      compress:
        global_defs: 
          DEBUG: false
        pure_funcs: ['console.log', 'alert']
    cleancss:
      keepSpecialComments: 0
      removeEmpty: true

