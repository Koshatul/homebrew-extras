require 'formula'

class Sslscan < Formula
  homepage 'https://github.com/rbsec/sslscan'
  url 'https://github.com/rbsec/sslscan/archive/1.10.0-rbsec.tar.gz'
  sha1 '746db4d2efabf487348c9ffd407ad527a5e0fe06'
  version '1.10.0'

  depends_on "openssl"

  # Fix compilation and statically link against OpenSSL 1.0.2 rather than 1.0.1
  patch :DATA

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
diff --git a/Makefile b/Makefile
index 8a38e4c..d18743f 100644
--- a/Makefile
+++ b/Makefile
@@ -23,8 +23,8 @@ LIBS      = -lssl -lcrypto
 # for static linking
 ifeq ($(STATIC_BUILD), TRUE)
 PWD          = $(shell pwd)/openssl
-LDFLAGS      += -L${PWD}/
-CFLAGS       += -I${PWD}/include/ -I${PWD}/
+LDFLAGS      = -L${PWD}/
+CFLAGS       = -I${PWD}/include/ -I${PWD}/
 LIBS         = -lssl -lcrypto -ldl
 GIT_VERSION  := $(GIT_VERSION)-static
 else
@@ -51,7 +51,7 @@ uninstall:
  rm -f $(MANPATH)man1/sslscan.1
 
 openssl/Makefile:
- [ -d openssl -a -d openssl/.git ] && true || git clone https://github.com/openssl/openssl ./openssl && cd ./openssl && git checkout OpenSSL_1_0_1-stable
+ [ -d openssl -a -d openssl/.git ] && true || git clone https://github.com/openssl/openssl ./openssl && cd ./openssl && git checkout OpenSSL_1_0_2-stable
 
 openssl/libcrypto.a: openssl/Makefile
  cd ./openssl; ./config no-shares

