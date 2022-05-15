PROJECT = "HackerNews.xcodeproj"

task :start do
  openProject
end

task :gen do
  if(File.exists?("#{PROJECT}"))
    puts("Deleting #{PROJECT}...")
    sleep(1.0)
    system("rm -rf #{PROJECT}")
  end

  system("xcodegen")
end

task :close do
  closeProject
end


def openProject
  puts("Opening #{PROJECT}")
  sleep(1.0)
  system("open #{PROJECT}")
end

def closeProject
  puts("Killing Xcode...")
  sleep(1.0)
  system("killall Xcode")
end
