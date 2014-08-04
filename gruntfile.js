module.exports = function(grunt){
  grunt.initConfig({
    stylus: {
      compile: {
        files: [{
          cwd: 'src/assets/css',
          src: 'index.styl',
          dest: 'src/files/css',
          expand: true,
          ext: '.css',
        }]
      }
    },
    watch: {
      js: {
        files: ['src/assets/js/**/*.js'],
        tasks: ['copy:js'],
      },
      css: {
        files: ['src/assets/css/**/*.css'],
        tasks: ['copy:css'],
      },
      stylus: {
        files: ['src/assets/css/**/*.styl'],
        tasks: ['stylus'],
      },
    },
    copy: {
      css: {
        files: [{
          cwd: 'src/assets/css/',
          src: ['**/*.css'],
          dest: 'src/files/css/',
          expand: true,
        }]
      },
      js: {
        files: [{
          cwd: 'src/assets/js/',
          src: ['**/*.js'],
          dest: 'src/files/js/',
          expand: true,
        }]
      },
      bootstrap: {
        files: [{
          cwd: 'bower_components/bootstrap/dist/',
          src: [
            'css/**/*.min.css',
            'js/**/*.min.js',
            'fonts/**/*'
          ],
          dest: 'src/files/vendor/bootstrap/',
          expand: true
        }]
      },
      jquery: {
        files: [{
          cwd: 'bower_components/jquery/',
          src: ['jquery.min.js','jquery.min.map'],
          dest: 'src/files/vendor/jquery/',
          expand: true
        }]
      }
    },
    clean: ["src/files/css", "src/files/js"]
  });

  grunt.loadNpmTasks('grunt-contrib-stylus');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-clean');

  grunt.registerTask('default', [
    'copy', 
    'stylus',
    'watch', 
  ]);
  grunt.registerTask('prepare', [
    'clean',
    'copy',
    'stylus'
  ]);
};