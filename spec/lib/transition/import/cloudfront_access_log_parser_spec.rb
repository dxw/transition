require "rails_helper"

describe Transition::Import::CloudfrontAccessLogParser::Entry do
  let(:line) { described_class.from_string("2020-05-29	23:54:02	DUB2-C1	618	54.195.247.25	GET	d12s8p8qcafwkr.cloudfront.net	/wp-cron.php	200	-	Wget/1.19.4%20(linux-gnu)	-	-	Miss	b2_BwCohclTL3enMv28Y88rRVmftK2D5Y6W-FL75T_fp-6yzbeavmg==	www.judiciary.uk	https	154	0.147	-	TLSv1.2	ECDHE-RSA-AES128-GCM-SHA256	Miss	HTTP/1.1	-	-	48838	0.146	Miss	text/html;%20charset=UTF-8	0	-	-") }
  let(:line_with_server_ip_and_referer) { described_class.from_string("2020-05-29	23:54:02	DUB2-C1	618	54.195.247.25	GET	d12s8p8qcafwkr.cloudfront.net	/wp-cron.php	200	fake-referer	Wget/1.19.4%20(linux-gnu)	-	-	Miss	b2_BwCohclTL3enMv28Y88rRVmftK2D5Y6W-FL75T_fp-6yzbeavmg==	www.judiciary.uk	https	154	0.147	127.0.0.1	TLSv1.2	ECDHE-RSA-AES128-GCM-SHA256	Miss	HTTP/1.1	-	-	48838	0.146	Miss	text/html;%20charset=UTF-8	0	-	-") }

  it "can be constructed from string" do
    expect(line).to be_a(Transition::Import::CloudfrontAccessLogParser::Entry)
  end

  it "should contain a parsed date" do
    expect(line.date).to eq(Time.zone.parse("2020-05-29 23:54:02"))
  end

  it "should contain a client IP" do
    expect(line.client_ip).to be_a(IP)
    expect(line.client_ip.to_s).to eq("54.195.247.25")
  end

  it "should contain a server IP if present" do
    expect(line_with_server_ip_and_referer.server_ip).to be_a(IP)
    expect(line_with_server_ip_and_referer.server_ip.to_s).to eq("127.0.0.1")
  end

  it "should return nil for server_ip if x-forwarded-for is '-'" do
    expect(line.server_ip).to be_nil
  end

  it "should contain a port" do
    expect(line.port).to eq(48_838)
  end

  it "should contain a status" do
    expect(line.status).to eq(200)
  end

  it "should contain the time taken formatted correctly" do
    expect(line.time_taken).to eq(0.000147)
  end

  it "should contain the user-agent" do
    expect(line.user_agent).to eq("Wget/1.19.4%20(linux-gnu)")
  end

  it "should correctly handle a nil user agent" do
    line_without_ua = described_class.from_string("2020-05-29	23:54:02	DUB2-C1	618	54.195.247.25	GET	d12s8p8qcafwkr.cloudfront.net	/wp-cron.php	200	-	-	-	-	Miss	b2_BwCohclTL3enMv28Y88rRVmftK2D5Y6W-FL75T_fp-6yzbeavmg==	www.judiciary.uk	https	154	0.147	-	TLSv1.2	ECDHE-RSA-AES128-GCM-SHA256	Miss	HTTP/1.1	-	-	48838	0.146	Miss	text/html;%20charset=UTF-8	0	-	-")
    expect(line_without_ua.user_agent).to be_nil
  end

  it "should contain the referer" do
    expect(line_with_server_ip_and_referer.user_referer).to eq("fake-referer")
  end

  it "should return nil for the referrer if it is not present" do
    expect(line.user_referrer).to be_nil
  end

  it "should contain the original host" do
    expect(line.host).to eq("www.judiciary.uk")
  end

  it "should contain the url" do
    expect(line.url).to eq("/wp-cron.php")
  end

  it "should handle strings containing invalid UTF-8 bytes" do
    line_with_invalid_char = described_class.from_string("2020-05-29	23:54:02	DUB2-C1	618	54.195.247.25	GET	d12s8p8qcafwkr.cloudfront.net	/wp-cron.php	200	-	Wget/1.19.4%20(linux-gnu)	/news?q=char\xE4	-	Miss	b2_BwCohclTL3enMv28Y88rRVmftK2D5Y6W-FL75T_fp-6yzbeavmg==	www.judiciary.uk	https	154	0.147	-	TLSv1.2	ECDHE-RSA-AES128-GCM-SHA256	Miss	HTTP/1.1	-	-	48838	0.146	Miss	text/html;%20charset=UTF-8	0	-	-")
    expect(line_with_invalid_char.query).to eq "/news?q=char\uFFFD"
  end
end

describe Transition::Import::CloudfrontAccessLogParser do
  it "should read entries for IO" do
    last = nil
    File.open("spec/fixtures/hits/cloudfront_example.log", "r") do |io|
      described_class.new(io) do |entry|
        last = entry
      end
    end

    expect(last.send("cs-uri-stem")).to eq "/announcements/circuit-bench-retirement-rennie/"
  end

  it "should allow reading entries from file" do
    last = nil
    described_class.from_file("spec/fixtures/hits/cloudfront_example.log") do |entry|
      last = entry
    end

    expect(last.send("cs-uri-stem")).to eq "/announcements/circuit-bench-retirement-rennie/"
  end
end
