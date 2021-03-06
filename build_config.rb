MRuby::Build.new do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :clang
  end

  conf.enable_debug

  conf.cc.flags << '-DMRB_INT64'

  conf.gembox 'full-core'
  conf.gem '../mruby-apr'
  # conf.gem '../ruby-progressbar'
  # conf.gem '../mruby-libuv'
  # conf.gem '../mruby-nurb'
  # conf.gem '../mruby-curses'
  conf.gem '../mruby-erb'
  # conf.gem '../mruby-sqlite'
  # conf.gem '../mruby-zlib'
  # conf.gem '../mruby-git'
  # conf.gem '../mruby-bin-git-curses'
  conf.gem github: 'iij/mruby-regexp-pcre'
  
  # # Libgit2
  # conf.cc.flags << `pkg-config libgit2 --cflags`.strip
  # conf.cxx.flags << `pkg-config libgit2 --cflags`.strip
  # conf.linker.flags_after_libraries << `pkg-config libgit2 --libs`.strip

  # # Libuv
  # conf.cc.flags << `pkg-config libuv --cflags`.strip
  # conf.linker.flags << `pkg-config libuv --libs`.strip
  
  # Curses
  # (May need to set library_paths, especially on Windows)
  # if /windows/i =~ ENV['OS']
  #   conf.linker.libraries = %w(pdcurses)
  # else
  #   conf.linker.libraries = %w(panel ncurses)
  # end
  
  # ZLib
  # conf.cc.include_paths << '/usr/local/opt/zlib/include'
  # conf.linker.library_paths << '/usr/local/opt/zlib/lib'
  # conf.linker.libraries << 'z'
end
