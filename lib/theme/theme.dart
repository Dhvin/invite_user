import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

IconThemeData fgicontheme = IconThemeData(color: HexColor("#2E3094"));
Color iconPrimary = HexColor("#76808A");
Color textPrimary = HexColor("#76808A");

class Global {
  static String token =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6Ijk1MWMwOGM1MTZhZTM1MmI4OWU0ZDJlMGUxNDA5NmY3MzQ5NDJhODciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbWFybG8tYmFuay1kZXYiLCJhdWQiOiJtYXJsby1iYW5rLWRldiIsImF1dGhfdGltZSI6MTY3MDQyODUxNiwidXNlcl9pZCI6IlJoSGdiY1U0cHZNMGR3RE90d1piTlhPOTlRMjMiLCJzdWIiOiJSaEhnYmNVNHB2TTBkd0RPdHdaYk5YTzk5UTIzIiwiaWF0IjoxNjcwNDI4NTE2LCJleHAiOjE2NzA0MzIxMTYsImVtYWlsIjoieGlob2g1NTQ5NkBkaW5lcm9hLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ4aWhvaDU1NDk2QGRpbmVyb2EuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.W2i-NrHOm4XNzdUd7CjHAkaABCezAo-5FlVM2ppr7PTbsYV_Zr2gknQTtxUIg2vvZAys0NVVeGVMbe_z3L-GLM6pNgI-VYva4VoU0q0zgCXRVljyP3zCSSGGFc1PQR8z8pijB4XBdq-lZ6HrrYdqbuP8ZMFtDgXfW-DO77O0wS8AZgu2ukwH_FtPOLRybfIM9c4np3dZwz5KgINWGU3EzlrWScftjRp3MqpCIgCB_qKbcNRdPeVk4T9RaiH2EBX_rsVNoG8O73uPVFXQc90ip5vNNs6VgLFcgMeRLRQpKzZtIz4IIEB4j0WnQOWit5KSo005RBarBeeGamiu6-GG_A';
}
