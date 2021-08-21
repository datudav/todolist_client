module.exports = {
    purge: [
        '../lib/todolistapp_web/templates/**/*.eex'
    ],
    darkMode: false, // or 'media' or 'class'
    theme: {
      extend: {
        fontFamily: {
          'poppins': ['"Poppins"']
        }
      },
    },
    variants: {
      backgroundColor: ['responsive', 'dark', 'group-hover', 'focus-within', 'hover', 'focus'],
      textColor: ['hover']
    },
    plugins: [],   
  }