require "ip"
require "time"

module Transition
  module Import
    class CloudfrontAccessLogParser
      def self.fields
        Entry::CLOUDFRONT_LOG_FIELDS.keys
      end

      class Entry < OpenStruct
        def self.from_string(line)
          mapping = {}
          x = nil
          line.scrub.split(/^(\d{4}-\d{2}-\d{2})\s(\d{2}:\d{2}:\d{2})\s(\w+-?\w+)\s(\d+)\s(\S+)\s(\w+)\s(\S+)\s(\S+)\s(\d+)\s(\S+)\s(\S+)\s(\S+)\s(\S+)\s(\w+)\s(\S+)\s(\S+)\s(\w+)\s(\d+)\s(\S+)\s(\S+|-)\s(\S+)\s(\S+)\s(\w+)\s(\S+)\s(\S+)\s(\S+)\s(\S+)\s(\S+)\s(\S+)\s(\S+)\s(\S+)\s(\S+)\s(\S+)$/).each_with_index do |value, i|
            next unless CloudfrontAccessLogParser.fields[i - 1]

            mapping[CloudfrontAccessLogParser.fields[i - 1]] = value unless i.zero?
            x = value if i.zero?
          end
          raise ArgumentError, "bad format: '#{line}, value #{x}'" unless x

          mapping[:date] = Time.zone.parse(mapping[:date] + " " + mapping[:time] + " UTC") unless mapping[:date].nil?
          mapping[:server_ip] = IP.new(mapping[:"x-forwarded-for"]) unless ["-", nil].include?(mapping[:"x-forwarded-for"])
          mapping[:client_ip] = IP.new(mapping[:"c-ip"]) unless mapping[:"c-ip"].nil?

          mapping[:port] = mapping[:"c-port"].to_i
          mapping[:status] = mapping[:"sc-status"].to_i

          mapping[:time_taken] = mapping[:"time-taken"].to_f / 1000

          mapping[:query] = mapping[:"cs-uri-query"] unless ["-", nil].include?(mapping[:"cs-uri-query"])

          mapping[:user_agent] = mapping[:"cs(User-Agent)"] unless ["-", nil].include?(mapping[:"cs(User-Agent)"])
          mapping[:user_agent].tr!("+", " ") unless mapping[:user_agent].nil?

          mapping[:user_referer] = mapping[:"cs(Referer)"] unless ["-", nil].include?(mapping[:"cs(Referer)"])
          new(mapping)
        end
      end

      def self.from_file(log_file)
        File.open(log_file, "r") do |io|
          new(io) do |entry|
            yield entry
          end
        end
      end

      def initialize(io)
        io.each_line do |line|
          next if line[0, 1] == "#"

          yield Entry.from_string(line)
        end
      end
    end
  end
end
