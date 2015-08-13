require 'formula'

class Sslyze < Formula
  homepage 'https://github.com/nabla-c0d3/sslyze'
  if OS.linux?
    if Hardware.is_64_bit?
      url 'https://github.com/nabla-c0d3/sslyze/releases/download/release-0.11/sslyze-0_11-linux64.zip'
      sha256 '90a322f8ae44cfb51e7261cd1cdb94e3afc327b28168ef5586ff2378f52f0380'
    else
      url 'https://github.com/nabla-c0d3/sslyze/releases/download/release-0.11/sslyze-0_11-linux32.zip'
      sha256 'd4f5ddf435f993a57f39cf4b574dd0d0f3aafe71846f9c4a35ab0bff47954329'
    end
  else
      url 'https://github.com/nabla-c0d3/sslyze/releases/download/release-0.11/sslyze-0_11-osx64.zip'
      sha256 '357098cb3c2c64c756b86b185d752158c8db82dfb551768acf72f66be50361b2'
  end
  version '0.11'

  def install
    #ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    #system "python", *Language::Python.setup_install_args(libexec)

    #bin.install Dir["#{libexec}/bin/*"]
    #bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])

    # FIX: For some reason when doing it the recommended way, the 
    # PluginChromeSha1Deprecation and PluginCertInfo plugins complain.
    # So for now just hack it
    (bin/"sslyze").write <<-EOS.undent
      #!/usr/bin/env bash
      cd  "#{libexec}" && ./sslyze.py "$@"
    EOS
    cd "sslyze" do
      libexec.install Dir['*']
    end
  end

  test do
    system "#{bin}/sslyze"
  end
end
