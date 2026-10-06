# Written by scripts/release.py in the Stenographer repo for each release.
# Do not edit by hand.
cask "stenographer" do
  version "1.0.178.0"
  sha256 "f1213dccf3ef1773f2aac88369a4fe44f40fcb9d05980f211546559d0e094ee6"

  url "https://github.com/agenticdevelopmentstudio/stenographer-releases/releases/download/v#{version}/Stenographer-#{version}.pkg"
  name "Stenographer"
  desc "Records Claude Code session activity"
  homepage "https://agenticstenographer.app/"

  livecheck do
    url "https://agenticstenographer.app/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "Stenographer-#{version}.pkg"

  uninstall launchctl: [
              "com.agentic-cookbook.stenographer",
              "com.agentic-cookbook.stenographer.menubar",
              "com.agenticdevelopmentstudio.stenographer",
            ],
            quit:      "com.agenticdevelopmentstudio.stenographer",
            script:    {
              executable: "/Applications/Stenographer.app/Contents/MacOS/stenographerd",
              args:       ["--uninstall-hooks"],
            },
            pkgutil:   "com.agenticdevelopmentstudio.stenographer",
            delete:    [
              "~/.claude/stenographer.sock",
              "~/Library/LaunchAgents/com.agentic-cookbook.stenographer.menubar.plist",
              "~/Library/LaunchAgents/com.agentic-cookbook.stenographer.plist",
              "~/Library/LaunchAgents/com.agenticdevelopmentstudio.stenographer.plist",
            ]

  zap trash: [
    "~/.claude/stenographer-capture.py",
    "~/.claude/stenographer-events",
    "~/Library/Logs/com.agentic-cookbook.stenographer",
    "~/Library/Logs/com.agenticdevelopmentstudio.stenographer",
  ]

  caveats <<~EOS
    The `steno` command at /usr/local/bin/steno is a link the Stenographer app
    manages: turn it on or off in Manage Stenographer Tools.
  EOS
end
