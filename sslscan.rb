require 'formula'

class Sslscan < Formula
  homepage 'https://github.com/rbsec/sslscan'
  url 'https://github.com/rbsec/sslscan/archive/239e01f489393f3777bddcd424072957e9ba00a5.zip'
  sha1 'ba1968a5b09e3cf45a7b160ce8052b04a2c426b7'

  # Remove hardcoded CFLAGS and LDFLAGS in Makefile
  patch :DATA

  def install
    if build.with? 'openssl'
      args = %W[
        CFLAGS=#{'-I' + Formula['openssl'].opt_prefix.to_s + '/include/'}
        LDFLAGS=#{'-L' + Formula['openssl'].opt_prefix.to_s + '/lib/'}
      ]
    else
      args = %W[]
    end
    system "make", *args
    bin.install "sslscan"
    man1.install "sslscan.1"
  end

  test do
    system "#{bin}/sslscan"
  end

  depends_on "openssl" => :recommended
end

__END__
diff --git a/Makefile b/Makefile
index 388d916..6ba9e9b 100644
--- a/Makefile
+++ b/Makefile
@@ -6,8 +6,8 @@ endif
 SRCS = sslscan.c
 BINPATH = /usr/bin/
 MANPATH = /usr/share/man/
-CFLAGS=-I/usr/local/ssl/include/ -I/usr/local/ssl/include/openssl/
-LDFLAGS=-L/usr/local/ssl/lib/
+#CFLAGS=-I/usr/local/ssl/include/ -I/usr/local/ssl/include/openssl/
+#LDFLAGS=-L/usr/local/ssl/lib/

 all: $(SRCS)
        $(CC) -Wall ${LDFLAGS} ${SRCS} ${CFLAGS} -lssl -lcrypto -o sslscan