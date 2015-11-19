MRuby::Build.new do |conf|
  # load specific toolchain settings

  # Gets set by the VS command prompts.
  # if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
  #   toolchain :visualcpp
  # else
    toolchain :clang
  # end

  # include the default GEMs
  conf.gembox 'full-core'
  conf.gem '../mruby-pdcurses'

  # C compiler settings
  # conf.cc do |cc|
    # cc.command = ENV['CC'] || 'gcc'
    # cc.flags = [ENV['CFLAGS'] || %w()]
    # cc.include_paths = ["#{root}/include"]
    # cc.defines = %w(DISABLE_GEMS)
    # cc.option_include_path = '-I%s'
    # cc.option_define = '-D%s'
    # cc.compile_options = "%{flags} -MMD -o %{outfile} -c %{infile}"
  # end

  # mrbc settings
  # conf.mrbc do |mrbc|
  #   mrbc.compile_options = "-g -B%{funcname} -o-" # The -g option is required for line numbers
  # end

  # Linker settings
  conf.linker do |linker|
  #   linker.command = ENV['LD'] || 'gcc'
  #   linker.flags = [ENV['LDFLAGS'] || []]
  #   linker.flags_before_libraries = []
    linker.libraries = %w(pdcurses)
  #   linker.flags_after_libraries = []
    linker.library_paths = ['../mruby-pdcurses/pdcurses/win32']
  #   linker.option_library = '-l%s'
  #   linker.option_library_path = '-L%s'
  #   linker.link_options = "%{flags} -o %{outfile} %{objs} %{libs}"
  end

  # Archiver settings
  # conf.archiver do |archiver|
  #   archiver.command = ENV['AR'] || 'ar'
  #   archiver.archive_options = 'rs %{outfile} %{objs}'
  # end
end
