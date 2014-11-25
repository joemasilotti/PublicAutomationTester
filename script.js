var target = UIATarget.localTarget();
var app = target.frontMostApp();

// target.delay(5);

var keepGoing = true;
while (keepGoing) {
  app.setPreferencesValueForKey("", "out");
  var script = app.preferencesValueForKey("in");
  UIALogger.logDebug("executing: " + script)
  var out = eval(script);
  // if (!out) { out = "nothing"; }
  UIALogger.logDebug("got: " + out)
  app.setPreferencesValueForKey("", "in");
  app.setPreferencesValueForKey(out, "out");
  target.delay(1);
}

target.delay(2);
app.mainWindow().logElementTree();
