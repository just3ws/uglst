if Rails.env.production?
  GC::Profiler.enable
end
