// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html' ;
import "controller/controller.dart";
void main()
{
  querySelector('#startButton').onClick.listen(testMethod);
  DivElement elem = querySelector('#svensTag');

}
void testMethod(MouseEvent args)
{
  controller testcontrol = new controller();
  testcontrol.gameOver();
}