class Readerwriterqueue < Formula
  desc "A fast single-producer, single-consumer lock-free queue for C++"
  homepage "https://github.com/cameron314/readerwriterqueue"
  url "https://github.com/cameron314/readerwriterqueue/archive/v1.0.6.tar.gz"
  sha256 "fc68f55bbd49a8b646462695e1777fb8f2c0b4f342d5e6574135211312ba56c1"
  license "BSD"

  depends_on "cmake" => :build

  def install
    ENV.cxx11

    mkdir "readerwriterqueue-build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <readerwriterqueue/readerwriterqueue.h>
      struct Foo {};
      using TestQueue = moodycamel::BlockingReaderWriterQueue<Foo>;
      int main() {
        TestQueue queue_;
        return 0;
      }
    EOS
  system ENV.cxx, "-std=c++11", "test.cpp", "-I#{include}", "-o", "test"
  system "./test"
  end
end
