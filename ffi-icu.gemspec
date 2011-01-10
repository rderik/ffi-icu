# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ffi-icu}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jari Bakken"]
  s.date = %q{2010-08-23}
  s.description = %q{Provides charset detection, locale sensitive collation and more. Depends on libicu.}
  s.email = %q{jari.bakken@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "benchmark/detect.rb",
     "benchmark/shared.rb",
     "ffi-icu.gemspec",
     "lib/ffi-icu.rb",
     "lib/ffi-icu/chardet.rb",
     "lib/ffi-icu/collation.rb",
     "lib/ffi-icu/lib.rb",
     "lib/ffi-icu/normalization.rb",
     "lib/ffi-icu/transliteration.rb",
     "lib/ffi-icu/uchar.rb",
     "spec/chardet_spec.rb",
     "spec/collation_spec.rb",
     "spec/normalization_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/transliteration_spec.rb",
     "test.c"
  ]
  s.homepage = %q{http://github.com/jarib/ffi-icu}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Simple FFI wrappers for things I need from ICU.}
  s.test_files = [
    "spec/chardet_spec.rb",
     "spec/normalization_spec.rb",
     "spec/transliteration_spec.rb",
     "spec/spec_helper.rb",
     "spec/collation_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>, [">= 0.6.3"])
      s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
    else
      s.add_dependency(%q<ffi>, [">= 0.6.3"])
      s.add_dependency(%q<rspec>, [">= 1.3.0"])
    end
  else
    s.add_dependency(%q<ffi>, [">= 0.6.3"])
    s.add_dependency(%q<rspec>, [">= 1.3.0"])
  end
end
