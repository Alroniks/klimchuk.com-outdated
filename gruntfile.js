module.exports = function(grunt){
  grunt.initConfig({
    stylus: {
      compile: {
        files: [{
          cwd: 'src/assets/css',
          src: '**/*.styl',
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
      //imagemin: {
      //  files: ['source/img/**/*.{png,jpg,gif}'],
      //  tasks: ['imagemin'],
      //}
    },
    // imagemin: {
    //   dynamic: {
    //     files: [{
    //       expand: true,
    //       cwd: 'source/img/',
    //       src: ['**/*.{png,jpg,gif}'],
    //       dest: 'dest/img/',
    //     }]
    //   }
    // },
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
          src: ['jquery.min.js'],
          dest: 'src/files/vendor/jquery/',
          expand: true
        }]
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-stylus');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-copy');

  grunt.registerTask('default', [
    'copy', 
    'stylus',
    'watch', 
  ]);
  grunt.registerTask('prepare', [
    'copy',
    'stylus'
  ]);
};