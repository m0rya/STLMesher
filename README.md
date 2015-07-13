# STLMesher

このプログラムは、コーディングによって、3Dオブジェクトを生成し、更にそれを3Dプリントアウト可能なSTLファイルとして出力することができるものです。

まず、プログラムを実行すると、Coding Hereのボックスが現れます。
そのボックスに、以下のコマンドに引数を与えて記述しenterを押すと
記述された通りの3Dオブジェクトが画面上に現れます。

更に、3Dオブジェクトを画面に表示させた状態で、Coding Hereのボックス内にmakeと記述し、
enterを押すことで、3Dプリントアウト可能なSTLファイルとして出力されます。


//===Reference===//

cylindar(float radius, float CylindarHeight, int resolution);
cube(float Cubelength);
cone(float radius, float ConeHeight, int resolution);
BezierSurface(int resolution, int Width, int Depth, int Height, float weight);

make

//=======//


//Caution//
cylindar, cube, coneにおいての"resolution"の値は、
円を三角形によって分割する時の、1つの三角形の角度を表します。
なので、例えばresolutionの値を60とすると、円を分割するための三角形の1つの角度が60度となるので
円は6個の三角形に分割され、ヘキサゴンの形になります。
プログラムが甘いので、奇数の値を入れると、上手く3Dで生成されないことがあります。





