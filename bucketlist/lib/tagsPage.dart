/*
  Color pickerColor = new Color(0xff443a49);
  Color currentColor = new Color(0xff443a49);

  changeColor(Color color) {
      setState(() => pickerColor = color);
    }

body: Center(
        child: new RaisedButton(
          child: new Text("Change Me!"),
          color: currentColor,
          onPressed: () {
            print(currentColor);
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return new AlertDialog(
                    title: const Text('Pick a color!'),
                    content: new SingleChildScrollView(
                      child: new ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: changeColor,
                        enableLabel: true,
                        pickerAreaHeightPercent: 0.8,
                      ),
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('Got it'),
                        onPressed: () {
                          setState(() => currentColor = pickerColor);
                          print(currentColor);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
        ),
      ),
 */