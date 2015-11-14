# Thanks! http://stackoverflow.com/questions/170956/how-can-i-find-which-operating-system-my-ruby-program-is-running-on
module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
   (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end

  def OS.linux?
    OS.unix? and not OS.mac?
  end
end

MRuby::Build.new('host') do |conf|
  # Gets set by the VS command prompts.
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :clang
  end

  if OS.mac?
    conf.cc.flags << '-m64'
    conf.cxx.flags << '-m64'
    conf.cc.flags << '-stdlib=libstdc++'
    conf.cxx.flags << '-stdlib=libstdc++'
    conf.linker.flags << '-stdlib=libstdc++'
  elsif OS.windows?
    # TODO: Can I check for 64 bit build environment?

    [conf.cc, conf.cxx].each do |compiler|
      compiler.flags = compiler.flags.flatten.map do |flag|
        if flag == "/MD"
          "/MT"
        else
          flag
        end
      end
    end
  end

  Dir.entries('mrbgems').reject { |f| f =~ /bin|test/ || !(f =~ /mruby/) }.each do |gem|
    conf.gem core: gem
  end

  conf.gem :github => 'iij/mruby-regexp-pcre'
  conf.gem :github => "jbreeden/mruby-apr"
  configure_mruby_apr(conf)
  conf.gem "../mrbgems/mruby-rubium"
  conf.gem "../mrbgems/mruby-bin-rubium"
  conf.gem "../mrbgems/mruby-cef"

  if ENV['DEBUG'] && (ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR'])
    conf.cc.flags << "/DEBUG"
    conf.cxx.flags << "/DEBUG"
  end

end

MRuby::Build.new('console') do |conf|
  # Gets set by the VS command prompts.
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :clang
  end

  if OS.mac?
    conf.cc.flags << '-m64'
    conf.cxx.flags << '-m64'
    conf.cc.flags << '-stdlib=libstdc++'
    conf.cxx.flags << '-stdlib=libstdc++'
    conf.linker.flags << '-stdlib=libstdc++'
  elsif OS.windows?
    [conf.cc, conf.cxx].each do |compiler|
      compiler.flags = compiler.flags.flatten.map do |flag|
        if flag == "/MD"
          "/MT"
        else
          flag
        end
      end
    end
  end

  conf.gembox 'full-core'
  conf.gem :github => 'iij/mruby-regexp-pcre'
  conf.gem :github => "jbreeden/mruby-apr"

  if ENV['DEBUG'] && (ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR'])
    conf.cc.flags << "/DEBUG"
    conf.cxx.flags << "/DEBUG"
  end
end
