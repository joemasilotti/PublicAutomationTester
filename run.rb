#!/usr/bin/env ruby
require 'pry'

# system('xcodebuild -workspace PublicAutomationTester.xcworkspace -scheme PublicAutomationTester NSObjCMessageLoggingEnabled=YES')
# system('xcodebuild -workspace PublicAutomationTester.xcworkspace -scheme PublicAutomationTester')

device = '5E22B057-E5D4-4D82-9CAF-B9C7527CC865'
template = '/Applications/Xcode.app/Contents/Applications/Instruments.app/Contents/PlugIns/AutomationInstrument.xrplugin/Contents/Resources/Automation.tracetemplate'
app = `find /Users/joemasilotti/Library/Developer/CoreSimulator/Devices -name PublicAutomationTester.app`.strip
script = '/Users/joemasilotti/workspace/PublicAutomationTester/script.js'
output = '/Users/joemasilotti/workspace/PublicAutomationTester/Output/'

cmd = "instruments -w '#{device}' -t '#{template}' '#{app}' -e UIASCRIPT '#{script}' -e UIARESULTSPATH '#{output}'"

system(cmd)
