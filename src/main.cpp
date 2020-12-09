#include <reckless/file_writer.hpp>
#include <reckless/severity_log.hpp>

int main(int argc, char **argv) {
  using log_t = reckless::severity_log<reckless::indent<4>, // Spaces of indent
                                       ' '                  // Field separator
                                       >;

  reckless::file_writer writer{"reckless_log.txt"};
  log_t log{&writer};

  const std::string line = "012345678";
  for (int i = 0; i < 15000; ++i) {
    log.info("%s", std::move(line));
  }

  std::this_thread::sleep_for(std::chrono::seconds{30});
}
