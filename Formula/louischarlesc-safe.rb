class LouischarlescSafe < Formula
  desc "C++11 header only RAII guards for mutexes and locks"
  homepage "https://github.com/LouisCharlesC/safe"
  url "https://github.com/LouisCharlesC/safe/archive/v1.0.1.tar.gz"
  sha256 "fb78674effead47a9e7dc899b79aff1a330be71346e56519bbc2e274e8298140"
  license "MIT"

  depends_on "cmake" => :build

  def install
    ENV.cxx11

    mkdir "safe-build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <safe/safe.h>
      int main() {
        safe::Safe<int> test;
        return 0;
      }
    EOS
  system ENV.cxx, "-std=c++11", "test.cpp", "-I#{include}", "-o", "test"
  system "./test"
  end
end
