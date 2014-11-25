var target = UIATarget.localTarget();
var app = target.frontMostApp();

var keepGoing = true;
while (keepGoing) {
  var script = app.preferencesValueForKey("script");
  eval(script);
  app.setPreferencesValueForKey("", "script");
  target.delay(1);
}

target.delay(2);
app.mainWindow().logElementTree();
