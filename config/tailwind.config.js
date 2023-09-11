const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      backgroundColor: {
        'operately-blue': '#3185FF',
        'operately-dark-blue': '#024FAC',
        'operately-blue-tint-1': '#E3F2FF',
        'operately-blue-tint-2': '#98C9FF',
      },
      borderColor: {
        'operately-blue': '#3185FF',
        'operately-dark-blue': '#024FAC',
        'operately-blue-tint-1': '#E3F2FF',
        'operately-blue-tint-2': '#98C9FF',
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      textColor: {
        'operately-blue': '#3185FF',
        'operately-dark-blue': '#024FAC',
        'operately-blue-tint-1': '#E3F2FF',
        'operately-blue-tint-2': '#98C9FF',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
