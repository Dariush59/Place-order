const { mix } = require('laravel-mix');

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */

// mix.js('resources/assets/js/app.js', 'public/js')
//    .sass('resources/assets/sass/app.scss', 'public/css');

mix.combine([
    'resources/assets/css/fontiran.css',
    'resources/assets/css/bootstrap.min.css',
    'resources/assets/css/blog-home.css',
    'resources/assets/css/bootstrap-rtl.min.css',
    'resources/assets/css/style.css',
],'public/css/all.css');


mix.combine([
    'resources/assets/js/jquery.js',
    'resources/assets/js/bootstrap.min.js',
],'public/js/all.js');