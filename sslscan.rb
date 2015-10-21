require 'formula'

class Sslscan < Formula
  homepage 'https://github.com/rbsec/sslscan'
  url 'https://github.com/rbsec/sslscan/archive/1.11.0-rbsec.tar.gz'
  sha1 'f5b3600b33181097f0afd49a3d1e894948da3d9c'
  version '1.11.0'

  depends_on "openssl"

  # Fix compilation and statically link against OpenSSL 1.0.2 rather than 1.0.1
  #patch :DATA

  def install
    ENV.deparallelize
    system "make"
    bin.install "sslscan"
    man1.install "sslscan.1"
  end

  test do
    system "#{bin}/sslscan"
  end
end

__END__
