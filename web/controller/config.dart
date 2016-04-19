class config
{
  static int dimBlockX = 4;
  static int dimBlockY = 4;
  static int fieldX = 24;
  static int fieldY = 48;

/* Field
  upwards
  [0][0] = column[0]row[0]
  [0][1] = column[0]row[1]
 */

  // Block size getter
  static int getBlockSizeX()
  {
    return dimBlockX;
  }

  static int getBlockSizeY()
  {
    return dimBlockY;
  }

  // Field size getter
  static int getFieldSizeX()
  {
    return fieldX;
  }

  static int getFieldSizeY()
  {
    return fieldY;
  }
}