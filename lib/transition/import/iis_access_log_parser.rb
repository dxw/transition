require "ip"
require "time"
require "ostruct"

# Original code (MIT) can be found here https://github.com/jpastuszek/iis-access-log-parser
# Deciding not to fork it and host it on a gemserver given this specific
# permutation will only live for a short time until UKRI transition is complete.
module Transition
  module Import
    class IISAccessLogParser
      def self.fields
        @fields || %i[date server_ip method url query port username client_ip user_agent user_referer host status substatus win32_status time_taken other unspecified]
      end

      def self.field=(fields)
        @fields = fields
      end

      class Entry < OpenStruct
        IIS_LOG_FIELDS = {
          date: "(\\d{4}-\\d{2}-\\d{2}[ T]\\d{2}:\\d{2}:\\d{2})",
          server_ip: "([^ ]*)",
          method: "([^ ]*)",
          url: "([^ ]*)",
          query: "([^ ]*)",
          port: "([^ ]*)",
          username: "([^ ]*)",
          client_ip: "([^ ]*)",
          user_agent: "([^ ]*)",
          user_referer: "([^ ]*)",
          host: "([^ ]*)",
          status: "([^ ]*)",
          substatus: "([^ ]*)",
          win32_status: "([^ ]*)",
          time_taken: "([^ ]*)",
        }.freeze

        def self.line_regex
          Regexp.new("^" + IIS_LOG_FIELDS.values.join("\\s"))
        end

        def self.from_string(line)
          mapping = {}
          x = nil
          line.scrub.split(line_regex).each_with_index do |value, i|
            mapping[IISAccessLogParser.fields[i - 1]] = value unless i.zero?
            x = value if i.zero?
          end
          raise ArgumentError, "bad format: '#{line}'" unless x

          mapping[:date] = Time.zone.parse(mapping[:date] + " UTC") unless mapping[:date].nil?
          mapping[:server_ip] = IP.new(mapping[:server_ip]) unless mapping[:server_ip].nil?
          mapping[:client_ip] = IP.new(mapping[:client_ip]) unless mapping[:client_ip].nil?

          mapping[:port] = mapping[:port].to_i
          mapping[:status] = mapping[:status].to_i
          mapping[:substatus] = mapping[:substatus].to_i
          mapping[:win32_status] = mapping[:win32_status].to_i

          mapping[:time_taken] = mapping[:time_taken].to_f / 1000

          mapping[:query] = nil if mapping[:query] == "-"
          mapping[:username] = nil if mapping[:username] == "-"
          mapping[:user_agent] = nil if mapping[:user_agent] == "-"

          mapping[:user_agent].tr!("+", " ") unless mapping[:user_agent].nil?

          mapping[:user_referer] = nil if mapping[:user_referer] == "-"

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
