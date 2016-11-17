exports.config =
  # See http://brunch.io/#documentation for docs.
  files:
    stylesheets:
      joinTo: 'styles/app.css'
      order:
        before: [
          'vendor/styles/unpure.css'
        ]
        after: [

        ]

    javascripts:
      joinTo: 'javascripts/app.js'
      order:
        before: [
        ]
        after: [
        ]

    autoReload:
      enabled:
        css: on
        js: on
        assets: on
