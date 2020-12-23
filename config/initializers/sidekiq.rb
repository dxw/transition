redis_url = ENV.fetch("REDIS_URL", "redis://dev:6379")
redis_url = "#{redis_url}/0"

options = {
  concurrency: Integer(ENV.fetch("RAILS_MAX_THREADS") { 5 }),
}

Sidekiq.configure_server do |config|
  config.options.merge!(options)
  config.redis = {
    url: redis_url,
    size: config.options[:concurrency] + 5,
  }
end

Sidekiq.configure_client do |config|
  config.options.merge!(options)
  config.redis = {
    url: redis_url,
    size: config.options[:concurrency] + 5,
  }
end

Sidekiq.logger.level = Logger::WARN if Rails.env.production?

# If passing multiple buckets in the W3C_LOG_BUCKET_NAME & CLOUDFRONT_LOG_BUCKET_NAME
# arguments, join them with `,` and they will be split into an array
# e.g. W3C_LOG_BUCKET_NAME="bucket1,bucket2,bucket3"

if ENV["REDIS_URL"].present?
  Sidekiq::Cron::Job.load_from_hash(
    {
      "daily_ingest_of_ukri_clf_logs" => {
        "class" => "IngestW3cLogWorker",
        "cron" => "0 19 * * *",
        "args" => ENV["W3C_LOG_BUCKET_NAME"],
      },
      "daily_ingest_of_cloudfront_logs" => {
        "class" => "IngestCloudfrontLogWorker",
        "cron" => "0 20 * * *",
        "args" => ENV["CLOUDFRONT_LOG_BUCKET_NAME"],
      },
    },
  )
end
