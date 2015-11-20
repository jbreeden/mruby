MRuby::Build.new do |conf|
  # Gets set by the VS command prompts.
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :clang
  end

  conf.gembox 'full-core'
  conf.gem '../mruby-curses'
  conf.gem github: 'jbreeden/mruby-apr'
  conf.gem github: 'jbreeden/mruby-sqlite'

  # Linker settings
  conf.linker do |linker|
    # These just happen to be the paths I used on my system.
    # You'll want to update these before building.
    if /windows/i =~ ENV['OS']
      linker.libraries = %w(pdcurses)
    else
      linker.libraries = %w(panel ncurses)
    end

    # These just happen to be the paths I used on my system.
    # You'll want to update these before building.
    if /windows/i =~ ENV['OS']
      linker.library_paths = ['./pdcurses/win32']
    else
      linker.library_paths = ['../ncurses-6.0/lib']
    end
  end
end
