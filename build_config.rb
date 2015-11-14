MRuby::Build.new do |conf|
  # load specific toolchain settings

  # Gets set by the VS command prompts.
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end

  # include the default GEMs
  [conf.cc.flags, conf.cxx.flags].each do |flags|
    flags << '-DMRB_INT64'
  end
  conf.gembox 'full-core'
  conf.gem '../mruby-apr'
  conf.gem '../mruby-sqlite'
  conf.gem '../mruby-sdl'
  conf.gem github: 'iij/mruby-regexp-pcre'
end
