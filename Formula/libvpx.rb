class Libvpx < Formula
  desc "VP8/VP9 video codec"
  homepage "https://www.webmproject.org/code/"
  url "https://github.com/webmproject/libvpx/archive/v1.8.2.tar.gz"
  sha256 "8735d9fcd1a781ae6917f28f239a8aa358ce4864ba113ea18af4bb2dc8b474ac"
  head "https://chromium.googlesource.com/webm/libvpx", :using => :git

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "ff6f98e9d0e276f2f45424de360eb862afa8603c9650080e79e751e0f4eddf88" => :catalina
    sha256 "0e1d5f53082f7718604f11a6df4ff9edd219892cd5eef4c4a7c5875dcf9876f2" => :mojave
    sha256 "b67db059b122aa25a17fff630cc04cba531a95b33b6032ac5ba78434325f0700" => :high_sierra
    sha256 "12c14d42a563fc9d2b94f6733b45816fb21e70f4fd3229c9398e115af49f9bc0" => :sierra
  end

  depends_on "yasm" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-examples
      --disable-unit-tests
      --enable-pic
      --enable-vp9-highbitdepth
    ]

    # https://bugs.chromium.org/p/webm/issues/detail?id=1475
    args << "--disable-avx512" if MacOS.version <= :el_capitan

    mkdir "macbuild" do
      system "../configure", *args
      system "make", "install"
    end
  end

  test do
    system "ar", "-x", "#{lib}/libvpx.a"
  end
end
