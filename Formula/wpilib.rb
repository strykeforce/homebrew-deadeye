class Wpilib < Formula
  desc "Open source computer vision library"
  homepage "https://github.com/wpilibsuite/allwpilib"
  url "https://github.com/wpilibsuite/allwpilib/archive/refs/tags/v2022.4.1.tar.gz"
  sha256 "0c5adb29655098e45b348baef46dca6f80c3877688d73f78aa7be1ca03a50ea1"
  license :cannot_represent

  keg_only "because it installs in a way that breaks cmake package search"

  depends_on "cmake" => :build
  depends_on "opencv"
 
  def install
    ENV.cxx11

    args = std_cmake_args + %W[
      -DWITH_JAVA=OFF
      -DWITH_CSCORE=ON
      -DWITH_WPIMATH=OFF
      -DWITH_WPILIB=OFF
      -DWITH_OLD_COMMANDS=OFF
      -DWITH_EXAMPLES=OFF
      -DWITH_TESTS=OFF
      -DWITH_GUI=OFF
      -DWITH_SIMULATION_MODULES=OFF
      -DWITH_FLAT_INSTALL=OFF
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end
  
  def caveats
    <<~EOS
      To use with a CMake project, add the following to the cmake command
       line when initializing the project build:

        -DCMAKE_PREFIX_PATH=$(brew --prefix wpilib) # for posix shell
        -DCMAKE_PREFIX_PATH=(brew --prefix wpilib) # for fish shell
    EOS
  end

end
