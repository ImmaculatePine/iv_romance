exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: {
        'js/app.js': /^js\/app|node_modules/,
        'js/admin.js': /^js\/admin|node_modules/
      }

      // To change the order of concatenation of files, explicitly mention here
      // order: {
      //   before: [
      //     "vendor/js/jquery-2.1.1.js",
      //     "vendor/js/bootstrap.min.js"
      //   ]
      // }
    },
    stylesheets: {
      joinTo: {
        'css/app.css': /^css\/app/,
        'css/admin.css': /^css\/admin/
      }
    },
    templates: {
      joinTo: 'js/app.js'
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ['static', 'css', 'scss', 'js', 'vendor'],
    // Where to compile files to
    public: '../priv/static'
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/],
      presets: ['env', 'react'],
      plugins: ['transform-object-rest-spread', 'transform-class-properties']
    },
    copycat: {
      fonts: ['node_modules/font-awesome/fonts']
    },
    sass: {
      options: {
        includePaths: [
          'node_modules/bulma',
          'node_modules/font-awesome/scss',
          'node_modules/simple-lightbox/dist'
        ]
      }
    }
  },

  modules: {
    autoRequire: {
      'js/app.js': ['js/app/app'],
      'js/admin.js': ['js/admin/admin']
    }
  },

  npm: {
    enabled: true
  }
}
