// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

void main()
{
  querySelector('#testButton').onClick.listen(testMethod);
}
void testMethod(MouseEvent args)
{
  querySelector('#output').text="TetrisAttack\'n Stuff.";
  TableCellElement elem = querySelector('#tableEntry');
  elem.style.backgroundColor = "black";
}