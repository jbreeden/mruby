MRuby::Build.new do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :clang
  end

  conf.gembox 'full-core'
  conf.gem '../mruby-libuv'
  conf.gem '../mruby-nurb'
  conf.gem '../mruby-glib'
  conf.gem github: 'iij/mruby-regexp-pcre'
  
  conf.cc.flags << `pkg-config libuv --cflags`.strip
  conf.cc.flags << `pkg-config gio-2.0 --cflags`.strip
  conf.cc.flags << `pkg-config glib-2.0 --cflags`.strip
  conf.linker.flags << `pkg-config libuv --libs`.strip
  conf.linker.flags << `pkg-config gio-2.0 --libs`.strip
  conf.linker.flags << `pkg-config glib-2.0 --libs`.strip
end
