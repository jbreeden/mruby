MRuby::Build.new do |conf|
  # Gets set by the VS command prompts.
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :clang
  end

  conf.gembox 'full-core'
  # This should point to where you downloaded mruby-curses
  conf.gem '../mruby-curses'
  conf.gem github: 'jbreeden/mruby-apr'
  conf.gem github: 'jbreeden/mruby-sqlite'

  # Linker settings
  conf.linker do |linker|
    if /windows/i =~ ENV['OS']
      linker.libraries = %w(pdcurses)
    else
      linker.libraries = %w(panel ncurses)
    end

    # These paths are just where I happened to build these libraries.
    # You'll want to update these before building.
    if /windows/i =~ ENV['OS']
      linker.library_paths = ['./pdcurses/win32']
    else
      linker.library_paths = ['../ncurses-6.0/lib']
    end
  end
end
