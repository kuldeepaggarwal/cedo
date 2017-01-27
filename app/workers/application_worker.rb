class ApplicationWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5, failures: :exhausted, backtrace: true, queue: :default
end
