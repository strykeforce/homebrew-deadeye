class Tinyfsm < Formula
  desc "A simple C++ finite state machine library"
  homepage "https://digint.ch/tinyfsm"
  url "https://github.com/jhh/tinyfsm/archive/v0.3.3.tar.gz"
  sha256 "9145524e4b684a29ca404aaa2aa76947cfb9cfbdf5fe34698a251a45a255c863"
  license "MIT"

  depends_on "cmake" => :build

  def install
    ENV.cxx11

    mkdir "spdlog-build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <tinyfsm.hpp>
      struct TestEvent : tinyfsm::Event {};
      int main() {
        return 0;
      }
    EOS
  system ENV.cxx, "-std=c++11", "test.cpp", "-I#{include}", "-o", "test"
  system "./test"
  end
end
