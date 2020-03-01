import math
import numpy as np
PI = 3.14
indexes = []
indexes.append(0)
i = 0

while(indexes[i] < 2 * PI):
    indexes.append(indexes[i] + 0.01)
    i = i + 1

f_sin = open("lut_sin.txt", "w")
f_cos = open("lut_cos.txt", "w")    


for i in range(0, len(indexes)):
    f_sin.writelines(str(np.int32(math.sin(indexes[i]) * math.pow(10, 16))))
    f_sin.writelines(str('\n'))

    f_cos.writelines(str(np.int32(math.cos(indexes[i]) * math.pow(10, 16))))
    f_cos.writelines(str('\n'))

f_sin.close()
f_cos.close()
