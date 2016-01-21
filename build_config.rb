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
  conf.gem '../mruby-bin-git-curses'
  ## Alternatively...
  # conf.gem github: 'jbreeden/mruby-curses'

  # Linker settings
  conf.linker do |linker|
    if /windows/i =~ ENV['OS']
      # Note, I renamed pdcurses.a to libpdcurses.a
      # so the linker can find it with -lpdcurses, which
      # is how MRuby will pass linker.libraries to the compiler.
      linker.libraries = %w(pdcurses)
    else
      linker.libraries = %w(panel ncurses)
    end

    # These paths just happen to be where I built the libraries.
    # You'll want to update these before building.
    if /windows/i =~ ENV['OS']
      linker.library_paths = ['./pdcurses/win32']
    else
      linker.library_paths = ['../ncurses-6.0/lib']
    end
  end
end
